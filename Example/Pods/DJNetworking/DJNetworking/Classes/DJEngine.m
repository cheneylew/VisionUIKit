//
//  DJEngine.m
//  DJNetworking
//
//  Created by Dejun Liu on 12/12/2016.
//  Copyright © 2016 DJNetworking. All rights reserved.
//

#import "DJEngine.h"
#import "DJRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <objc/runtime.h>

static dispatch_queue_t DJ_request_completion_callback_queue() {
    static dispatch_queue_t _DJ_request_completion_callback_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _DJ_request_completion_callback_queue = dispatch_queue_create("com.DJnetworking.request.completion.callback.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return _DJ_request_completion_callback_queue;
}

#pragma mark - DJRequest Binding

@implementation NSObject (BindingDJRequestForNSURLSessionTask)

static NSString * const kDJRequestBindingKey = @"kDJRequestBindingKey";

- (void)bindingRequest:(DJRequest *)request {
    objc_setAssociatedObject(self, (__bridge CFStringRef)kDJRequestBindingKey, request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DJRequest *)bindedRequest {
    DJRequest *request = objc_getAssociatedObject(self, (__bridge CFStringRef)kDJRequestBindingKey);
    return request;
}

@end

#pragma mark - DJEngine

@interface DJEngine (){
    dispatch_semaphore_t _lock;
}

@property (nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) AFJSONRequestSerializer *afJSONRequestSerializer;
@property (nonatomic, strong) AFPropertyListRequestSerializer *afPropertyListRequestSerializer;

@property (nonatomic, strong) AFJSONResponseSerializer *afJSONResponseSerializer;
@property (nonatomic, strong) AFXMLParserResponseSerializer *afXMLParserResponseSerializer;
@property (nonatomic, strong) AFPropertyListResponseSerializer *afPropertyListResponseSerializer;

@end

@implementation DJEngine

+ (instancetype)sharedEngine {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _lock = dispatch_semaphore_create(1);
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    return self;
}

+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)dealloc {
    if (_sessionManager) {
        [_sessionManager invalidateSessionCancelingTasks:YES];
    }
}

#pragma mark - Public Methods

- (NSUInteger)sendRequest:(DJRequest *)request
        completionHandler:(nullable DJCompletionHandler)completionHandler {
    if (request.requestType == kDJRequestNormal) {
        return [self DJ_dataTaskWithRequest:request completionHandler:completionHandler];
    } else if (request.requestType == kDJRequestUpload) {
        return [self DJ_uploadTaskWithRequest:request completionHandler:completionHandler];
    } else if (request.requestType == kDJRequestDownload) {
        return [self DJ_downloadTaskWithRequest:request completionHandler:completionHandler];
    } else {
        NSAssert(NO, @"Unknown request type.");
        return 0;
    }
}

- (nullable DJRequest *)cancelRequestByIdentifier:(NSUInteger)identifier {
    if (identifier == 0) return nil;
    __block DJRequest *request = nil;
    DJLock();
    [self.sessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask *task, NSUInteger idx, BOOL *stop) {
        if (task.taskIdentifier == identifier) {
            request = task.bindedRequest;
            [task cancel];
            *stop = YES;
        }
    }];
    DJUnlock();
    return request;
}

- (nullable DJRequest *)getRequestByIdentifier:(NSUInteger)identifier {
    if (identifier == 0) return nil;
    __block DJRequest *request = nil;
    DJLock();
    [self.sessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask *task, NSUInteger idx, BOOL *stop) {
        if (task.taskIdentifier == identifier) {
            request = task.bindedRequest;
            *stop = YES;
        }
    }];
    DJUnlock();
    return request;
}

- (NSInteger)networkReachability {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

#pragma mark - Private Methods

- (NSUInteger)DJ_dataTaskWithRequest:(DJRequest *)request
                   completionHandler:(DJCompletionHandler)completionHandler {
    NSString *httpMethod = nil;
    static dispatch_once_t onceToken;
    static NSArray *httpMethodArray = nil;
    dispatch_once(&onceToken, ^{
        httpMethodArray = @[@"GET", @"POST", @"HEAD", @"DELETE", @"PUT", @"PATCH"];
    });
    if (request.httpMethod >= 0 && request.httpMethod < httpMethodArray.count) {
        httpMethod = httpMethodArray[request.httpMethod];
    }
    NSAssert(httpMethod.length > 0, @"The HTTP method not found.");
    
    AFHTTPRequestSerializer *requestSerializer = [self DJ_getRequestSerializer:request];
    
    NSError *serializationError = nil;
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:httpMethod
                                                                 URLString:request.url
                                                                parameters:request.parameters
                                                                     error:&serializationError];
    
    if (serializationError) {
        if (completionHandler) {
            dispatch_async(DJ_request_completion_callback_queue(), ^{
                completionHandler(nil, serializationError);
            });
        }
        return 0;
    }
    
    [self DJ_processURLRequest:urlRequest byDJRequest:request];
    
    NSURLSessionDataTask *dataTask = nil;
    __weak __typeof(self)weakSelf = self;
    dataTask = [self.sessionManager dataTaskWithRequest:urlRequest
                                      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf DJ_processResponse:response
                                object:responseObject
                                 error:error
                               request:request
                     completionHandler:completionHandler];
    }];
    
    [dataTask bindingRequest:request];
    [request setIdentifier:dataTask.taskIdentifier];
    [dataTask resume];
    
    return request.identifier;
}

- (NSUInteger)DJ_uploadTaskWithRequest:(DJRequest *)request
                      completionHandler:(DJCompletionHandler)completionHandler {
    
    AFHTTPRequestSerializer *requestSerializer = [self DJ_getRequestSerializer:request];
    
    __block NSError *serializationError = nil;
    NSMutableURLRequest *urlRequest = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                              URLString:request.url
                                                                             parameters:request.parameters
                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [request.uploadFormDatas enumerateObjectsUsingBlock:^(DJUploadFormData *obj, NSUInteger idx, BOOL *stop) {
            if (obj.fileData) {
                if (obj.fileName && obj.mimeType) {
                    [formData appendPartWithFileData:obj.fileData name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
                } else {
                    [formData appendPartWithFormData:obj.fileData name:obj.name];
                }
            } else if (obj.fileURL) {
                NSError *fileError = nil;
                if (obj.fileName && obj.mimeType) {
                    [formData appendPartWithFileURL:obj.fileURL name:obj.name fileName:obj.fileName mimeType:obj.mimeType error:&fileError];
                } else {
                    [formData appendPartWithFileURL:obj.fileURL name:obj.name error:&fileError];
                }
                if (fileError) {
                    serializationError = fileError;
                    *stop = YES;
                }
            }
        }];
    } error:&serializationError];
    
    if (serializationError) {
        if (completionHandler) {
            dispatch_async(DJ_request_completion_callback_queue(), ^{
                completionHandler(nil, serializationError);
            });
        }
        return 0;
    }
    
    [self DJ_processURLRequest:urlRequest byDJRequest:request];
    
    NSURLSessionUploadTask *uploadTask = nil;
    __weak __typeof(self)weakSelf = self;
    uploadTask = [self.sessionManager uploadTaskWithStreamedRequest:urlRequest
                                                           progress:request.progressBlock
                                                  completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf DJ_processResponse:response
                                object:responseObject
                                 error:error
                               request:request
                     completionHandler:completionHandler];
    }];
    
    [uploadTask bindingRequest:request];
    [request setIdentifier:uploadTask.taskIdentifier];
    [uploadTask resume];
    
    return request.identifier;
}

- (NSUInteger)DJ_downloadTaskWithRequest:(DJRequest *)request
                       completionHandler:(DJCompletionHandler)completionHandler {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:request.url]];
    [self DJ_processURLRequest:urlRequest byDJRequest:request];
    
    NSURL *downloadFileSavePath;
    BOOL isDirectory;
    if(![[NSFileManager defaultManager] fileExistsAtPath:request.downloadSavePath isDirectory:&isDirectory]) {
        isDirectory = NO;
    }
    if (isDirectory) {
        NSString *fileName = [urlRequest.URL lastPathComponent];
        downloadFileSavePath = [NSURL fileURLWithPath:[NSString pathWithComponents:@[request.downloadSavePath, fileName]] isDirectory:NO];
    } else {
        downloadFileSavePath = [NSURL fileURLWithPath:request.downloadSavePath isDirectory:NO];
    }
    
    NSURLSessionDownloadTask *downloadTask = nil;
    downloadTask = [self.sessionManager downloadTaskWithRequest:urlRequest
                                                       progress:request.progressBlock
                                                    destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                        return downloadFileSavePath;
                                                    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                        if (completionHandler) {
                                                            completionHandler(filePath, error);
                                                        }
                                                    }];
    
    [downloadTask bindingRequest:request];
    [request setIdentifier:downloadTask.taskIdentifier];
    [downloadTask resume];
    
    return request.identifier;
}

- (void)DJ_processURLRequest:(NSMutableURLRequest *)urlRequest byDJRequest:(DJRequest *)request {
    if (request.headers.count > 0) {
        [request.headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            //if (![urlRequest valueForHTTPHeaderField:field]) {
                [urlRequest setValue:value forHTTPHeaderField:field];
            //}
        }];
    }
    urlRequest.timeoutInterval = request.timeoutInterval;
}

- (void)DJ_processResponse:(NSURLResponse *)response
                    object:(id)responseObject
                     error:(NSError *)error
                   request:(DJRequest *)request
         completionHandler:(DJCompletionHandler)completionHandler {
    NSError *serializationError = nil;
    if (request.responseSerializerType != kDJResponseSerializerRAW) {
        AFHTTPResponseSerializer *responseSerializer = [self DJ_getResponseSerializer:request];
        responseObject = [responseSerializer responseObjectForResponse:response data:responseObject error:&serializationError];
    }
    
    if (completionHandler) {
        if (serializationError) {
            completionHandler(nil, serializationError);
        } else {
            completionHandler(responseObject, error);
        }
    }
}

- (AFHTTPRequestSerializer *)DJ_getRequestSerializer:(DJRequest *)request {
    if (request.requestSerializerType == kDJRequestSerializerRAW) {
        return self.sessionManager.requestSerializer;
    } else if(request.requestSerializerType == kDJRequestSerializerJSON) {
        return self.afJSONRequestSerializer;
    } else if (request.requestSerializerType == kDJRequestSerializerPlist) {
        return self.afPropertyListRequestSerializer;
    } else {
        NSAssert(NO, @"Unknown request serializer type.");
        return nil;
    }
}

- (AFHTTPResponseSerializer *)DJ_getResponseSerializer:(DJRequest *)request {
    if (request.responseSerializerType == kDJResponseSerializerRAW) {
        return self.sessionManager.responseSerializer;
    } else if (request.responseSerializerType == kDJResponseSerializerJSON) {
        return self.afJSONResponseSerializer;
    } else if (request.responseSerializerType == kDJResponseSerializerPlist) {
        return self.afPropertyListResponseSerializer;
    } else if (request.responseSerializerType == kDJResponseSerializerDJL) {
        return self.afDJLParserResponseSerializer;
    } else {
        NSAssert(NO, @"Unknown response serializer type.");
        return nil;
    }
}

#pragma mark - Accessor

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
        _sessionManager.completionQueue = DJ_request_completion_callback_queue();
    }
    return _sessionManager;
}

- (AFJSONRequestSerializer *)afJSONRequestSerializer {
    if (!_afJSONRequestSerializer) {
        _afJSONRequestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    return _afJSONRequestSerializer;
}

- (AFPropertyListRequestSerializer *)afPropertyListRequestSerializer {
    if (!_afPropertyListRequestSerializer) {
        _afPropertyListRequestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    return _afPropertyListRequestSerializer;
}

- (AFJSONResponseSerializer *)afJSONResponseSerializer {
    if (!_afJSONResponseSerializer) {
        _afJSONResponseSerializer = [AFJSONResponseSerializer serializer];
        // Append more other commonly-used types to the JSON responses accepted MIME types.
        _afJSONResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        
    }
    return _afJSONResponseSerializer;
}

- (AFXMLParserResponseSerializer *)afDJLParserResponseSerializer {
    if (!_afXMLParserResponseSerializer) {
        _afXMLParserResponseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    return _afXMLParserResponseSerializer;
}

- (AFPropertyListResponseSerializer *)afPropertyListResponseSerializer {
    if (!_afPropertyListResponseSerializer) {
        _afPropertyListResponseSerializer = [AFPropertyListResponseSerializer serializer];
    }
    return _afPropertyListResponseSerializer;
}

@end
