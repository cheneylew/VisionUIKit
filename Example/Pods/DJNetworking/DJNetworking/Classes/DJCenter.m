//
//  DJCenter.m
//  DJNetworking
//
//  Created by Dejun Liu on 12/12/2016.
//  Copyright © 2016 DJNetworking. All rights reserved.
//

#import "DJCenter.h"
#import "DJRequest.h"
#import "DJEngine.h"

@interface DJCenter ()

@property (nonatomic, copy, nullable, readwrite) NSString *generalServer;
@property (nonatomic, strong, readwrite) NSMutableDictionary<NSString *, id> *generalParameters;
@property (nonatomic, strong, readwrite) NSMutableDictionary<NSString *, NSString *> *generalHeaders;

@property (nonatomic, copy) DJCenterResponseProcessBlock responseProcessHandler;

@end

@implementation DJCenter

+ (instancetype)center {
    return [[[self class] alloc] init];
}

+ (instancetype)defaultCenter {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self center];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

#pragma mark - Public Instance Methods for DJCenter

- (void)setupConfig:(void(^)(DJConfig *config))block {
    DJConfig *config = [[DJConfig alloc] init];
    config.consoleLog = NO;
    DJ_SAFE_BLOCK(block, config);
    
    if (config.generalServer) {
        self.generalServer = config.generalServer;
    }
    if (config.generalParameters.count > 0) {
        [self.generalParameters addEntriesFromDictionary:config.generalParameters];
    }
    if (config.generalHeaders.count > 0) {
        [self.generalHeaders addEntriesFromDictionary:config.generalHeaders];
    }
    if (config.callbackQueue != NULL) {
        self.callbackQueue = config.callbackQueue;
    }
    if (config.generalUserInfo) {
        self.generalUserInfo = config.generalUserInfo;
    }
    self.consoleLog = config.consoleLog;
}

- (void)setResponseProcessBlock:(DJCenterResponseProcessBlock)block {
    self.responseProcessHandler = block;
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock {
    return [self sendRequest:configBlock onProgress:nil onSuccess:nil onFailure:nil onFinished:nil];
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock {
    return [self sendRequest:configBlock onProgress:nil onSuccess:successBlock onFailure:nil onFinished:nil];
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onFailure:(nullable DJFailureBlock)failureBlock {
    return [self sendRequest:configBlock onProgress:nil onSuccess:nil onFailure:failureBlock onFinished:nil];
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock {
    return [self sendRequest:configBlock onProgress:nil onSuccess:nil onFailure:nil onFinished:finishedBlock];
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock {
    return [self sendRequest:configBlock onProgress:nil onSuccess:successBlock onFailure:failureBlock onFinished:nil];
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock {
    return [self sendRequest:configBlock onProgress:nil onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock {
    return [self sendRequest:configBlock onProgress:progressBlock onSuccess:successBlock onFailure:failureBlock onFinished:nil];
}

- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock {
    DJRequest *request = [DJRequest request];
    DJ_SAFE_BLOCK(configBlock, request);
    
    [self DJ_processRequest:request onProgress:progressBlock onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
    
    return [self DJ_sendRequest:request];
}

- (DJBatchRequest *)sendBatchRequest:(DJBatchRequestConfigBlock)configBlock
                           onSuccess:(nullable DJBatchSuccessBlock)successBlock
                           onFailure:(nullable DJBatchFailureBlock)failureBlock
                          onFinished:(nullable DJBatchFinishedBlock)finishedBlock {
    DJBatchRequest *batchRequest = [[DJBatchRequest alloc] init];
    DJ_SAFE_BLOCK(configBlock, batchRequest);
    
    if (batchRequest.requestArray.count > 0) {
        if (successBlock) {
            [batchRequest setValue:successBlock forKey:@"_batchSuccessBlock"];
        }
        if (failureBlock) {
            [batchRequest setValue:failureBlock forKey:@"_batchFailureBlock"];
        }
        if (finishedBlock) {
            [batchRequest setValue:finishedBlock forKey:@"_batchFinishedBlock"];
        }
        
        [batchRequest.responseArray removeAllObjects];
        for (DJRequest *request in batchRequest.requestArray) {
            [batchRequest.responseArray addObject:[NSNull null]];
            [self DJ_processRequest:request
                         onProgress:nil
                          onSuccess:nil
                          onFailure:nil
                         onFinished:^(id responseObject, NSError *error) {
                             [batchRequest onFinishedOneRequest:request response:responseObject error:error];
                         }];
            [self DJ_sendRequest:request];
        }
        return batchRequest;
    } else {
        return nil;
    }
}

- (DJChainRequest *)sendChainRequest:(DJChainRequestConfigBlock)configBlock
                           onSuccess:(nullable DJBatchSuccessBlock)successBlock
                           onFailure:(nullable DJBatchFailureBlock)failureBlock
                          onFinished:(nullable DJBatchFinishedBlock)finishedBlock {
    DJChainRequest *chainRequest = [[DJChainRequest alloc] init];
    DJ_SAFE_BLOCK(configBlock, chainRequest);
    
    if (chainRequest.firstRequest) {
        if (successBlock) {
            [chainRequest setValue:successBlock forKey:@"_chainSuccessBlock"];
        }
        if (failureBlock) {
            [chainRequest setValue:failureBlock forKey:@"_chainFailureBlock"];
        }
        if (finishedBlock) {
            [chainRequest setValue:finishedBlock forKey:@"_chainFinishedBlock"];
        }
        
        [self DJ_sendChainRequest:chainRequest withRequest:chainRequest.firstRequest];
        return chainRequest;
    } else {
        return nil;
    }
}

#pragma mark - Public Class Methods for DJCenter

+ (void)setupConfig:(void(^)(DJConfig *config))block {
    [[DJCenter defaultCenter] setupConfig:block];
}

+ (void)setResponseProcessBlock:(DJCenterResponseProcessBlock)block {
    [[DJCenter defaultCenter] setResponseProcessBlock:block];
}

+ (void)setGeneralHeaderValue:(nullable NSString *)value forField:(NSString *)field {
    [[DJCenter defaultCenter].generalHeaders setValue:value forKey:field];
}

+ (void)setGeneralParameterValue:(nullable NSString *)value forKey:(NSString *)key {
    [[DJCenter defaultCenter].generalParameters setValue:value forKey:key];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:nil onSuccess:nil onFailure:nil onFinished:nil];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:nil onSuccess:successBlock onFailure:nil onFinished:nil];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onFailure:(nullable DJFailureBlock)failureBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:nil onSuccess:nil onFailure:failureBlock onFinished:nil];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:nil onSuccess:nil onFailure:nil onFinished:finishedBlock];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:nil onSuccess:successBlock onFailure:failureBlock onFinished:nil];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:nil onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:progressBlock onSuccess:successBlock onFailure:failureBlock onFinished:nil];
}

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock {
    return [[DJCenter defaultCenter] sendRequest:configBlock onProgress:progressBlock onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
}

+ (DJBatchRequest *)sendBatchRequest:(DJBatchRequestConfigBlock)configBlock
                           onSuccess:(nullable DJBatchSuccessBlock)successBlock
                           onFailure:(nullable DJBatchFailureBlock)failureBlock
                          onFinished:(nullable DJBatchFinishedBlock)finishedBlock {
    return [[DJCenter defaultCenter] sendBatchRequest:configBlock onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
}

+ (DJChainRequest *)sendChainRequest:(DJChainRequestConfigBlock)configBlock
                           onSuccess:(nullable DJBatchSuccessBlock)successBlock
                           onFailure:(nullable DJBatchFailureBlock)failureBlock
                          onFinished:(nullable DJBatchFinishedBlock)finishedBlock {
    return [[DJCenter defaultCenter] sendChainRequest:configBlock onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
}

+ (void)cancelRequest:(NSUInteger)identifier {
    [self cancelRequest:identifier onCancel:nil];
}

+ (void)cancelRequest:(NSUInteger)identifier
             onCancel:(nullable DJCancelBlock)cancelBlock {
    DJRequest *request = [[DJEngine sharedEngine] cancelRequestByIdentifier:identifier];
    DJ_SAFE_BLOCK(cancelBlock, request);
}

+ (nullable DJRequest *)getRequest:(NSUInteger)identifier {
    return [[DJEngine sharedEngine]getRequestByIdentifier:identifier];
}

+ (BOOL)isNetworkReachable {
    return [DJEngine sharedEngine].networkReachability != 0;
}

#pragma mark - Private Methods for DJCenter

- (void)DJ_sendChainRequest:(DJChainRequest *)chainRequest withRequest:(DJRequest *)request {
    __weak __typeof(self)weakSelf = self;
    [self DJ_processRequest:request
                 onProgress:nil
                  onSuccess:nil
                  onFailure:nil
                 onFinished:^(id responseObject, NSError *error) {
                     __strong __typeof(weakSelf)strongSelf = weakSelf;
                     [chainRequest onFinishedOneRequest:chainRequest.firstRequest response:responseObject error:error];
                     if (chainRequest.nextRequest) {
                         [strongSelf DJ_sendChainRequest:chainRequest withRequest:chainRequest.nextRequest];
                     }
                 }];
    
    [self DJ_sendRequest:request];
}

- (void)DJ_processRequest:(DJRequest *)request
               onProgress:(DJProgressBlock)progressBlock
                onSuccess:(DJSuccessBlock)successBlock
                onFailure:(DJFailureBlock)failureBlock
               onFinished:(DJFinishedBlock)finishedBlock {
    
    // set callback blocks for the request object.
    if (successBlock) {
        [request setValue:successBlock forKey:@"_successBlock"];
    }
    if (failureBlock) {
        [request setValue:failureBlock forKey:@"_failureBlock"];
    }
    if (finishedBlock) {
        [request setValue:finishedBlock forKey:@"_finishedBlock"];
    }
    if (progressBlock && request.requestType != kDJRequestNormal) {
        [request setValue:progressBlock forKey:@"_progressBlock"];
    }
    
    // add general user info to the request object.
    if (!request.userInfo && self.generalUserInfo) {
        request.userInfo = self.generalUserInfo;
    }
    
    // add general parameters to the request object.
    if (request.useGeneralParameters && self.generalParameters.count > 0) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters addEntriesFromDictionary:self.generalParameters];
        if (request.parameters.count > 0) {
            [parameters addEntriesFromDictionary:request.parameters];
        }
        request.parameters = parameters;
    }
    
    // add general headers to the request object.
    if (request.useGeneralHeaders && self.generalHeaders.count > 0) {
        NSMutableDictionary *headers = [NSMutableDictionary dictionary];
        [headers addEntriesFromDictionary:self.generalHeaders];
        if (request.headers) {
            [headers addEntriesFromDictionary:request.headers];
        }
        request.headers = headers;
    }
    
    // process url for the request object.
    if (request.url.length == 0) {
        if (request.server.length == 0 && request.useGeneralServer && self.generalServer.length > 0) {
            request.server = self.generalServer;
        }
        if (request.api.length > 0) {
            NSURL *baseURL = [NSURL URLWithString:request.server];
            // ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected.
            if ([[baseURL path] length] > 0 && ![[baseURL absoluteString] hasSuffix:@"/"]) {
                baseURL = [baseURL URLByAppendingPathComponent:@""];
            }
            request.url = [[NSURL URLWithString:request.api relativeToURL:baseURL] absoluteString];
        } else {
            request.url = request.server;
        }
    }
    NSAssert(request.url.length > 0, @"The request url can't be null.");
}

- (NSUInteger)DJ_sendRequest:(DJRequest *)request {
    
    if (self.consoleLog) {
        if (request.requestType == kDJRequestDownload) {
            NSLog(@"\n============ [DJRequest Info] ============\nrequest download url: %@\nrequest save path: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", request.url, request.downloadSavePath, request.headers, request.parameters);
        } else {
            NSLog(@"\n============ [DJRequest Info] ============\nrequest url: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", request.url, request.headers, request.parameters);
        }
    }
    
    // send the request through DJEngine.
    return [[DJEngine sharedEngine] sendRequest:request completionHandler:^(id responseObject, NSError *error) {
        // the completionHandler will be execured in a private concurrent dispatch queue.
        if (error) {
            [self DJ_failureWithError:error forRequest:request];
        } else {
            [self DJ_successWithResponse:responseObject forRequest:request];
        }
    }];
}

- (void)DJ_successWithResponse:(id)responseObject forRequest:(DJRequest *)request {
    
    NSError *processError = nil;
    // custom processing the response data.
    DJ_SAFE_BLOCK(self.responseProcessHandler, request, responseObject, &processError);
    if (processError) {
        [self DJ_failureWithError:processError forRequest:request];
        return;
    }
    
    if (self.consoleLog) {
        if (request.requestType == kDJRequestDownload) {
            NSLog(@"\n============ [DJResponse Data] ===========\nrequest download url: %@\nresponse data: %@\n==========================================\n", request.url, responseObject);
        } else {
            if (request.responseSerializerType == kDJResponseSerializerRAW) {
                NSLog(@"\n============ [DJResponse Data] ===========\nrequest url: %@ \nresponse data: \n%@\n==========================================\n", request.url, [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            } else {
                NSLog(@"\n============ [DJResponse Data] ===========\nrequest url: %@ \nresponse data: \n%@\n==========================================\n", request.url, responseObject);
            }
        }
    }
    
    if (self.callbackQueue) {
        __weak __typeof(self)weakSelf = self;
        dispatch_async(self.callbackQueue, ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf DJ_execureSuccessBlockWithResponse:responseObject forRequest:request];
        });
    } else {
        // execure success block on a private concurrent dispatch queue.
        [self DJ_execureSuccessBlockWithResponse:responseObject forRequest:request];
    }
}

- (void)DJ_execureSuccessBlockWithResponse:(id)responseObject forRequest:(DJRequest *)request {
    DJ_SAFE_BLOCK(request.successBlock, responseObject);
    DJ_SAFE_BLOCK(request.finishedBlock, responseObject, nil);
    [request cleanCallbackBlocks];
}

- (void)DJ_failureWithError:(NSError *)error forRequest:(DJRequest *)request {
    
    if (self.consoleLog) {
        NSLog(@"\n=========== [DJResponse Error] ===========\nrequest url: %@ \nerror info: \n%@\n==========================================\n", request.url, error);
    }
    
    if (request.retryCount > 0) {
        request.retryCount --;
        // retry current request after 2 seconds.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self DJ_sendRequest:request];
        });
        return;
    }
    
    if (self.callbackQueue) {
        __weak __typeof(self)weakSelf = self;
        dispatch_async(self.callbackQueue, ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf DJ_execureFailureBlockWithError:error forRequest:request];
        });
    } else {
        // execure failure block in a private concurrent dispatch queue.
        [self DJ_execureFailureBlockWithError:error forRequest:request];
    }
}

- (void)DJ_execureFailureBlockWithError:(NSError *)error forRequest:(DJRequest *)request {
    DJ_SAFE_BLOCK(request.failureBlock, error);
    DJ_SAFE_BLOCK(request.finishedBlock, nil, error);
    [request cleanCallbackBlocks];
}

#pragma mark - Accessor

- (NSMutableDictionary<NSString *, id> *)generalParameters {
    if (!_generalParameters) {
        _generalParameters = [NSMutableDictionary dictionary];
    }
    return _generalParameters;
}

- (NSMutableDictionary<NSString *, NSString *> *)generalHeaders {
    if (!_generalHeaders) {
        _generalHeaders = [NSMutableDictionary dictionary];
    }
    return _generalHeaders;
}

@end

#pragma mark - DJConfig

@implementation DJConfig
@end
