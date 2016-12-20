//
//  VSNetClient.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSHttpClient.h"
#import <AFNetworking/AFNetworking.h>
#import <KKCategories/KKCategories.h>
#import "VSConfig.h"

@interface VSHttpClient()

PP_STRONG(AFHTTPSessionManager, manager)
PP_STRONG(NSMutableArray, dowloadManagerQueue)
PP_STRONG(NSMutableArray, uploadManagerQueue)

PP_COPY_BLOCK(AspectHttpHeader, globalHeaderBlock)
PP_COPY_BLOCK(AspectHttpParams, globalParamsBlock)
PP_COPY_BLOCK(AspectHttpResponse, globalResponseBlock)

@end

@implementation VSHttpClient
SINGLETON_IMPL(VSHttpClient)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.manager                                            = [AFHTTPSessionManager manager];
    
    //设置请求的数据Content-Type.
    //[AFJSONRequestSerializer serializer] json方式操作
    //[AFHTTPRequestSerializer serializer] 以其它方式提交
    self.manager.requestSerializer                          = [AFJSONRequestSerializer serializer];
    //设置响应接收数据的Content-Type.
    //[AFJSONResponseSerializer serializer] 只接收application/json; charset=utf-8数据。
    //[AFHTTPResponseSerializer serializer] 可接收任意http响应的格式。如text/plain等
    self.manager.responseSerializer                         = [AFHTTPResponseSerializer serializer];
    self.manager.securityPolicy                             = [VSHttpClient CustomSecurityPolicy];
    
}

- (NSMutableArray *)dowloadManagerQueue {
    if (_dowloadManagerQueue == nil) {
        _dowloadManagerQueue = [NSMutableArray new];
    }
    return _dowloadManagerQueue;
}

- (NSMutableArray *)uploadManagerQueue {
    if (_uploadManagerQueue == nil) {
        _uploadManagerQueue = [NSMutableArray new];
    }
    return _uploadManagerQueue;
}

#pragma mark Private

+ (void)InitClientWithProcessGlobalHeader:(AspectHttpHeader)headerBlock
                             globalParams:(AspectHttpParams) paramsBlock
                           globalResponse:(AspectHttpResponse) responseBlock {
    [VSHttpClient sharedInstance].globalHeaderBlock     = headerBlock;
    [VSHttpClient sharedInstance].globalParamsBlock     = paramsBlock;
    [VSHttpClient sharedInstance].globalResponseBlock   = responseBlock;
}

+ (AFSecurityPolicy*)CustomSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    if (!cerPath) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        return securityPolicy;
    } else {
        // AFSSLPinningModeCertificate 使用证书验证模式
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        
        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        // 如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        
        //validatesDomainName 是否需要验证域名，默认为YES；
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
        //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        //如置为NO，建议自己添加对应域名的校验逻辑。
        securityPolicy.validatesDomainName = NO;
        securityPolicy.pinnedCertificates = [NSSet setWithObjects:certData, nil];
        
        return securityPolicy;
    }
}

- (NSString *)absoluteURLWithPath:(NSString *)path {
    NSMutableString *absoluteURLString = [NSMutableString stringWithString:self.baseURLString];
    return [absoluteURLString stringByAppendingPathComponent:path];
}

- (void)creatUploadTaskWithRequest:(NSURLRequest *)request
                          progress:(void (^)(NSProgress *progress)) progress
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(VSErrorDataModel* dataModel))failure {
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [self.uploadManagerQueue addObject:manager];
    manager.securityPolicy = [VSHttpClient CustomSecurityPolicy];
    
    WEAK_SELF;
    WEAK(manager);
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:progress
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      [weakself.uploadManagerQueue removeObject:weakmanager];
                      [weakself processWithTask:nil
                                 responseObject:responseObject
                                          error:error
                                        success:success
                                        failure:failure];
                  }];
    
    [uploadTask resume];
}

- (void)processRequestMethod:(VSRequestParams*) rq_params
                  Serializer:(AFHTTPRequestSerializer **) serializer
                          params:(NSDictionary **) parameters {
    if (self.globalHeaderBlock) {
        NSDictionary *globalHeader = self.globalHeaderBlock(rq_params);
        [globalHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [*serializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    if (self.globalParamsBlock) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:*parameters];
        [params addEntriesFromDictionary:self.globalParamsBlock(rq_params)];
        *parameters = params;
    }
}

- (void)processWithTask:(NSURLSessionDataTask *) task
         responseObject:(id)responseObject
                  error:(NSError *)error
                success:(void (^)(id responseObject))success
                failure:(void (^)(VSErrorDataModel* dataModel))failure {
    if (!error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            DLog(@"\n\ntask:%lu\nsuccess:\n%@\n\n", (unsigned long)task.taskIdentifier, responseObject);
            BLOCK_SAFE_RUN(success, responseObject);
            return;
        }
        NSString *responseStr = [responseObject jk_UTF8String];
        NSDictionary *responseDic = [responseStr jk_dictionaryValue];
        if (responseStr && !responseDic) {
            VSErrorDataModel *error = [VSErrorDataModel InitErrorType:VSErrorType_ResponseValidJSON];
//            DLog(@"\n\ntask:%lu\nerror:\n%@\n\n", (unsigned long)task.taskIdentifier, error);
            BLOCK_SAFE_RUN(failure,error);
            return;
        };
        
//        DLog(@"\n\ntask:%lu\nsuccess:\n%@\n\n", (unsigned long)task.taskIdentifier, responseDic);
        if (self.globalResponseBlock) {
            id result = self.globalResponseBlock(responseDic);
            BLOCK_SAFE_RUN(success, result);
        } else {
            BLOCK_SAFE_RUN(success, responseDic);
        }
    } else {
        VSErrorDataModel *errorModel    = [VSErrorDataModel InitErrorType:VSErrorType_ResponseSystemError];
        errorModel.error                = error;
        
//        DLog(@"\n\ntask:%lu\nerror:\n%@\n\n", (unsigned long)task.taskIdentifier, errorModel);
        BLOCK_SAFE_RUN(failure,errorModel);
    }
}


#pragma mark Public

- (void)requestGet:(NSString *)path
        parameters:(id)parameters
           success:(void (^)(id))success
           failure:(void (^)(VSErrorDataModel *))failure {
    [self request:path
           method:VSRequestMethodGet
       parameters:parameters
          success:success
          failure:failure];
}

- (void)requestPost:(NSString *)path
         parameters:(id)parameters
            success:(void (^)(id))success
            failure:(void (^)(VSErrorDataModel *))failure {
    [self request:path
           method:VSRequestMethodPost
       parameters:parameters
          success:success
          failure:failure];
}

- (void)request:(NSString *)path
         method:(VSRequestMethod)method
     parameters:(id)parameters
        success:(void (^)(id))success
        failure:(void (^)(VSErrorDataModel *))failure {
    [self request:path
           method:method
       parameters:parameters
         progress:nil
          success:success
          failure:failure];
}

- (void)request:(NSString *)path
         method:(VSRequestMethod)method
     parameters:(id)parameters
       progress:(void (^)(NSProgress *)) progress
        success:(void (^)(id responseObject))success
        failure:(void (^)(VSErrorDataModel* dataModel))failure {
    
    VSRequestParams *rq_params = [VSRequestParams new];
    rq_params.url              = [self absoluteURLWithPath:path];
    rq_params.method           = method;
    rq_params.params           = parameters;
    
    WEAK_SELF;
    if (self.globalHeaderBlock) {
        NSDictionary *globalHeader = self.globalHeaderBlock(rq_params);
        [globalHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [weakself.manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    if (self.globalParamsBlock) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [params addEntriesFromDictionary:self.globalParamsBlock(rq_params)];
        parameters = params;
    }
    
    NSString *absoluteURLString = [self absoluteURLWithPath:path];
    if (method == VSRequestMethodGet) {
        [self.manager GET:absoluteURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            BLOCK_SAFE_RUN(progress, downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [weakself processWithTask:task responseObject:responseObject error:nil success:success failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [weakself processWithTask:task responseObject:nil error:error success:success failure:failure];
        }];
    }else if (method == VSRequestMethodPost) {
        [self.manager POST:absoluteURLString
                parameters:parameters
                  progress:^(NSProgress * _Nonnull uploadProgress) {
            BLOCK_SAFE_RUN(progress, uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakself processWithTask:task responseObject:responseObject error:nil success:success failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakself processWithTask:task responseObject:nil error:error success:success failure:failure];
        }];
    }
}

#pragma mark Download

- (void)downloadWithFileURL:(NSURL *) url
                   progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                 completion:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    [self downloadWithFileURL:url
                localFilePath:documentsDirectoryURL
                localFileName:nil
                     progress:downloadProgressBlock
                   completion:completionHandler];
}

- (void)downloadWithFileURL:(NSURL *) url
              localFilePath:(NSURL *)filePathURL
              localFileName:(NSString *) fileName
                   progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                 completion:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [self.dowloadManagerQueue addObject:manager];
    manager.securityPolicy = [VSHttpClient CustomSecurityPolicy];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    WEAK_SELF;
    WEAK(manager);
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:downloadProgressBlock destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        if (filePathURL == nil || fileName == nil) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } else {
            return [filePathURL URLByAppendingPathComponent:fileName];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [weakself.dowloadManagerQueue removeObject:weakmanager];
        completionHandler(response, filePath, error);
    }];
    [downloadTask resume];
}

#pragma mark Upload File

- (void)uploadToURLString:(NSString *) urlString
               parameters:(NSDictionary *)parameters
              uploadFiles:(NSArray *) uploadFiles
                 progress:(void (^)(NSProgress *progress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(VSErrorDataModel* dataModel))failure {
    
    VSRequestParams *rq_params = [VSRequestParams new];
    rq_params.url              = urlString;
    rq_params.method           = VSRequestMethodPost;
    rq_params.params           = parameters;
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    [self processRequestMethod:rq_params Serializer:&serializer params:&parameters];
    
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:urlString
                                                                                             parameters:parameters
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [uploadFiles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            VSUploadFile *file = obj;
           [formData appendPartWithFileURL:[[NSURL fileURLWithPath:file.localFileDIR] URLByAppendingPathComponent:file.localFileName]
                                      name:file.fileServerKey
                                  fileName:file.localFileName
                                  mimeType:file.mimeType
                                     error:nil];
        }];
    } error:nil];
    
    [self creatUploadTaskWithRequest:request progress:progress success:success failure:failure];
}

- (void)uploadToURLString:(NSString *) urlString
               parameters:(NSDictionary *)parameters
                 fileType:(VSFileType)type
                 fileData:(NSData *) fileData
                serverKey:(NSString *) serverKey
                 progress:(void (^)(NSProgress *progress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(VSErrorDataModel* dataModel))failure {
    NSString *mimeType = nil;
    switch (type) {
        case VSFileTypeJPG:
            mimeType = @"image/jpeg";
            break;
        case VSFileTypePNG:
            mimeType = @"image/png";
            break;
        case VSFileTypeStream:
            mimeType = @"application/octet-stream";
            break;
    }
    
    VSRequestParams *rq_params = [VSRequestParams new];
    rq_params.url              = urlString;
    rq_params.method           = VSRequestMethodPost;
    rq_params.params           = parameters;
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    [self processRequestMethod:rq_params Serializer:&serializer params:&parameters];
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:urlString
                                                                                             parameters:parameters
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                  [formData appendPartWithFileData:fileData
                                                                                                              name:serverKey
                                                                                                          fileName:@"mobileFile"
                                                                                                          mimeType:mimeType];
                                                                              } error:nil];
    
    [self creatUploadTaskWithRequest:request progress:progress success:success failure:failure];
}

- (void)uploadToURLString:(NSString *) urlString
               parameters:(NSDictionary *)parameters
                 fileData:(NSData *) fileData
                 progress:(void (^)(NSProgress *progress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(VSErrorDataModel* dataModel))failure {
    VSRequestParams *rq_params = [VSRequestParams new];
    rq_params.url              = urlString;
    rq_params.method           = VSRequestMethodPost;
    rq_params.params           = parameters;
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    [self processRequestMethod:rq_params Serializer:&serializer params:&parameters];
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:urlString
                                                                                             parameters:parameters
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                  [formData appendPartWithHeaders:nil body:fileData];
                                                                              } error:nil];
    
    [self creatUploadTaskWithRequest:request progress:progress success:success failure:failure];
}


@end

@implementation VSUploadFile

+ (VSUploadFile *)InitWithServerKey:(NSString *)serverKey
                               mime:(NSString *)mime
                            fileDIR:(NSString *)fileDIR
                           fileName:(NSString *)fileName {
    VSUploadFile *file = [VSUploadFile new];
    file.fileServerKey = serverKey;
    file.mimeType = mime;
    file.localFileDIR = fileDIR;
    file.localFileName = fileName;
    return file;
}

@end

@implementation VSRequestParams

@end
