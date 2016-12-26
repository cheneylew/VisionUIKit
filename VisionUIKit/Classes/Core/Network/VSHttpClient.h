//
//  VSNetClient.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>
#import "VSErrorDataModel.h"

typedef enum : NSUInteger {
    VSRequestMethodGet,
    VSRequestMethodPost
} VSRequestMethod;

typedef enum : NSUInteger {
    VSFileTypePNG,
    VSFileTypeJPG,
    VSFileTypeStream,
} VSFileType;

@class VSRequestParams;
typedef NSDictionary* (^AspectHttpHeader)(VSRequestParams *);                    //设置全局Header需要插入的参数
typedef NSDictionary* (^AspectHttpParams)(VSRequestParams *);                    //设置全局请求提交参数需要插入的参数
typedef id (^AspectHttpResponse)(NSDictionary *responseDic);                     //设置全局Response结果自定义处理结果

@interface VSHttpClient : NSObject
SINGLETON_ITF(VSHttpClient)

PP_STRONG(NSString, baseURLString)

/**
 全局过滤处理请求与响应数据。【可选】
 如果不初始化，则:
 header     不额外增加任何参数
 params     不额外增加提交参数
 repsonse   按照字典返回数据

 @param headerBlock     全局Header需要插入的K-V
 @param paramsBlock     全局请求参数需要插入的K-V
 @param responseBlock   全局响应结果字典统一处理为你想要的对象
 */
+ (void)InitClientWithProcessGlobalHeader:(AspectHttpHeader) headerBlock
                             globalParams:(AspectHttpParams) paramsBlock
                           globalResponse:(AspectHttpResponse) responseBlock;

- (NSString *)baseURLString;

#pragma mark 基础网络请求
- (void)request:(NSString *)path
         method:(VSRequestMethod)method
     parameters:(id)parameters
       progress:(void (^)(NSProgress *)) progress
        success:(void (^)(id responseObject))success
        failure:(void (^)(VSErrorDataModel* dataModel))failure;

#pragma mark 快速Get/Post 推荐
- (void)requestGet:(NSString *)path
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(VSErrorDataModel* dataModel))failure;

- (void)requestPost:(NSString *)path
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(VSErrorDataModel* dataModel))failure;

#pragma mark 下载文件

/**
 下载文件到Document/download文件夹，以网络上的名称自动命名

 @param url                   目标文件地址
 @param downloadProgressBlock 下载进度
 @param completionHandler     下载完成并保存成功的回调
 */
- (void)downloadWithFileURL:(NSURL *) url
                   progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                 completion:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 下载文件到指定文件夹

 @param url                   目标文件地址
 @param filePathURL           本地文件夹目录
 @param fileName              自定义下载后的名称
 @param downloadProgressBlock 下载进度
 @param completionHandler     下载完成并保存成功的回调
 */
- (void)downloadWithFileURL:(NSURL *) url
              localFilePath:(NSURL *) filePathURL
              localFileName:(NSString *) fileName
                   progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                 completion:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

#pragma mark 上传

/**
 上传本地文件到指定地址，可携带参数和文件，采用Post方式提交

 @param urlString   上传地址
 @param parameters  上传Post的参数
 @param uploadFiles 上传的本地文件数组：VSUploadFile
 @param progress    上传进度
 @param success     上传成功回调
 @param failure     上传失败回调
 */
- (void)uploadToURLString:(NSString *) urlString
               parameters:(NSDictionary *)parameters
              uploadFiles:(NSArray *) uploadFiles
                 progress:(void (^)(NSProgress *progress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(VSErrorDataModel* dataModel))failure;

/**
 文件以二进制方式提交

 @param urlString  <#urlString description#>
 @param parameters <#parameters description#>
 @param fileData   <#fileData description#>
 @param serverKey  一般是file，
 @param progress   <#progress description#>
 @param success    <#success description#>
 @param failure    <#failure description#>
 */
- (void)uploadToURLString:(NSString *) urlString
               parameters:(NSDictionary *)parameters
                 fileType:(VSFileType)type
                 fileData:(NSData *) fileData
                serverKey:(NSString *) serverKey
                 progress:(void (^)(NSProgress *progress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(VSErrorDataModel* dataModel))failure;

/**
 文件以二进制流方式直接提交

 @param urlString  <#urlString description#>
 @param parameters <#parameters description#>
 @param fileData   <#fileData description#>
 @param progress   <#progress description#>
 @param success    <#success description#>
 @param failure    <#failure description#>
 */
- (void)uploadToURLString:(NSString *) urlString
               parameters:(NSDictionary *)parameters
                 fileData:(NSData *) fileData
                 progress:(void (^)(NSProgress *progress)) progress
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(VSErrorDataModel* dataModel))failure;
@end

@interface VSUploadFile : NSObject

PP_STRONG(NSString, fileServerKey)  //服务器按照key value来接收文件，传入服务器需要的key。一般是file

/**
 application/octet-stream           （任意的二进制数据）
 image/jpeg                          jpg
 image/png                           png
 image/gif                          （GIF图像）
 text/html                          （HTML文档）
 text/plain                         （纯文本）
 application/pdf                    （PDF文档）
 video/mpeg                         （MPEG动画）
 application/msword                 （Microsoft Word文件）
 application/x-www-form-urlencoded  （使用HTTP的POST方法提交的表单）
 multipart/form-data                （同上，但主要用于表单提交时伴随文件上传的场合）
 */
PP_STRONG(NSString, mimeType)
PP_STRONG(NSString, localFileDIR)   //本地文件目录
PP_STRONG(NSString, localFileName)  //本地文件名称

+ (VSUploadFile *)InitWithServerKey:(NSString *) serverKey
                               mime:(NSString *) mime
                            fileDIR:(NSString *) fileDIR
                           fileName:(NSString *) fileName;

@end

@interface VSRequestParams : NSObject

PP_STRONG(NSString, url);
PP_ASSIGN_BASIC(VSRequestMethod, method)
PP_STRONG(NSDictionary, params)

@end
