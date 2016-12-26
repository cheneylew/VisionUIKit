//
//  DJRequest.h
//  DJNetworking
//
//  Created by Dejun Liu on 12/12/2016.
//  Copyright © 2016 DJNetworking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJConst.h"

NS_ASSUME_NONNULL_BEGIN

@class DJUploadFormData;

/**
 `DJRequest` is the base class for all network requests invoked by DJCenter.
 */
@interface DJRequest : NSObject

/**
 Creates and returns a new `DJRequest` object.
 */
+ (instancetype)request;

/**
 The unique identifier for a DJRequest object, the value is assigned by DJCenter when the request is sent,
 NOTE: DO NOT overwrite the identifier value in order to ensure consistent default behavior.
 */
@property (nonatomic, assign) NSUInteger identifier;

/**
 The server address for request, eg. "http://example.com/v1/", if `nil` (default) and the `useGeneralServer` property is `YES` (default), the `generalServer` of DJCenter is used.
 */
@property (nonatomic, copy, nullable) NSString *server;

/**
 The API interface path for request, eg. "foo/bar", `nil` by default.
 */
@property (nonatomic, copy, nullable) NSString *api;

/**
 The final URL of request, which is combined by `server` and `api` properties, eg. "http://example.com/v1/foo/bar", `nil` by default.
 NOTE: when you manually set the value for `url`, the `server` and `api` properties will be ignored.
 */
@property (nonatomic, copy, nullable) NSString *url;

/**
 The parameters for request, if `useGeneralParameters` property is `YES` (default), the `generalParameters` of DJCenter will be appended to the `parameters`.
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString *, id> *parameters;

/**
 The HTTP headers for request, if `useGeneralHeaders` property is `YES` (default), the `generalHeaders` of DJCenter will be appended to the `headers`.
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSString *> *headers;

@property (nonatomic, assign) BOOL useGeneralServer;        //!< Whether use `generalServer` of DJCenter or not when request `server` is `nil`, `YES` by default.
@property (nonatomic, assign) BOOL useGeneralHeaders;       //!< Whether append `generalHeaders` of DJCenter to request `headers` or not, `YES` by default.
@property (nonatomic, assign) BOOL useGeneralParameters;    //!< Whether append `generalParameters` of DJCenter to request `parameters` or not, `YES` by default.

/**
 Type for request: Normal, Upload or Download, `kDJRequestNormal` by default.
 */
@property (nonatomic, assign) DJRequestType requestType;

/**
 HTTP method for request, `kDJHTTPMethodPOST` by default, see `DJHTTPMethodType` enum for details.
 */
@property (nonatomic, assign) DJHTTPMethodType httpMethod;

/**
 Parameter serialization type for request, `kDJRequestSerializerRAW` by default, see `DJRequestSerializerType` enum for details.
 */
@property (nonatomic, assign) DJRequestSerializerType requestSerializerType;

/**
 Response data serialization type for request, `kDJResponseSerializerJSON` by default, see `DJResponseSerializerType` enum for details.
 */
@property (nonatomic, assign) DJResponseSerializerType responseSerializerType;

/**
 Timeout interval for request, `60` seconds by default.
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 The retry count for current request when error occurred, `0` by default.
 */
@property (nonatomic, assign) NSUInteger retryCount;

/**
 User info for current request, which could be used to distinguish requests with same context, if `nil` (default), the `generalUserInfo` of DJCenter is used.
 */
@property (nonatomic, strong, nullable) NSDictionary *userInfo;

/**
 Success block for request, called when current request completed successful, the block will execute in `callbackQueue` of DJCenter.
 */
@property (nonatomic, copy, readonly, nullable) DJSuccessBlock successBlock;

/**
 Failure block for request, called when error occurred, the block will execute in `callbackQueue` of DJCenter.
 */
@property (nonatomic, copy, readonly, nullable) DJFailureBlock failureBlock;

/**
 Finished block for request, called when current request is finished, the block will execute in `callbackQueue` of DJCenter.
 */
@property (nonatomic, copy, readonly, nullable) DJFinishedBlock finishedBlock;

/**
 Progress block for upload/download request, called when the upload/download progress is updated,
 NOTE: This block is called on the session queue, not the `callbackQueue` of DJCenter !!!
 */
@property (nonatomic, copy, readonly, nullable) DJProgressBlock progressBlock;

/**
 Nil out all callback blocks when a request is finished to break the potential retain cycle.
 */
- (void)cleanCallbackBlocks;

/**
 Upload files form data for upload request, `nil` by default, see `DJUploadFormData` class and `AFMultipartFormData` protocol for details.
 NOTE: This property is effective only when `requestType` is assigned to `kDJRequestUpload`.
 */
@property (nonatomic, strong, nullable) NSMutableArray<DJUploadFormData *> *uploadFormDatas;

/**
 Local save path for downloaded file, `nil` by default.
 NOTE: This property is effective only when `requestType` is assigned to `kDJRequestDownload`.
 */
@property (nonatomic, copy, nullable) NSString *downloadSavePath;

///----------------------------------------------------
/// @name Quickly Methods For Add Upload File Form Data
///----------------------------------------------------

- (void)addFormDataWithName:(NSString *)name fileData:(NSData *)fileData;
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData;
- (void)addFormDataWithName:(NSString *)name fileURL:(NSURL *)fileURL;
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL;

@end

#pragma mark - DJBatchRequest

///------------------------------------------------------
/// @name DJBatchRequest Class for sending batch requests
///------------------------------------------------------

@interface DJBatchRequest : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<DJRequest *> *requestArray;
@property (nonatomic, strong, readonly) NSMutableArray<id> *responseArray;
- (void)onFinishedOneRequest:(DJRequest *)request response:(nullable id)responseObject error:(nullable NSError *)error;
- (void)cancelWithBlock:(nullable void (^)())cancelBlock;

@end

#pragma mark - DJChainRequest

///------------------------------------------------------
/// @name DJChainRequest Class for sending chain requests
///------------------------------------------------------

@interface DJChainRequest : NSObject

@property (nonatomic, strong, readonly) DJRequest *firstRequest;
@property (nonatomic, strong, readonly) DJRequest *nextRequest;
- (DJChainRequest *)onFirst:(DJRequestConfigBlock)firstBlock;
- (DJChainRequest *)onNext:(DJChainNextBlock)nextBlock;
- (void)onFinishedOneRequest:(DJRequest *)request response:(nullable id)responseObject error:(nullable NSError *)error;
- (void)cancelWithBlock:(nullable void (^)())cancelBlock;

@end

#pragma mark - DJUploadFormData

/**
 `DJUploadFormData` is the class for describing and carring the upload file data, see `AFMultipartFormData` protocol for details.
 */
@interface DJUploadFormData : NSObject

/**
 The name to be associated with the specified data. This property must not be `nil`.
 */
@property (nonatomic, copy) NSString *name;

/**
 The file name to be used in the `Content-Disposition` header. This property is not recommended be `nil`.
 */
@property (nonatomic, copy, nullable) NSString *fileName;

/**
 The declared MIME type of the file data. This property is not recommended be `nil`.
 */
@property (nonatomic, copy, nullable) NSString *mimeType;

/**
 The data to be encoded and appended to the form data, and it is prior than `fileURL`.
 */
@property (nonatomic, strong, nullable) NSData *fileData;

/**
 The URL corresponding to the file whose content will be appended to the form, BUT, when the `fileData` is assigned，the `fileURL` will be ignored.
 */
@property (nonatomic, strong, nullable) NSURL *fileURL;

// NOTE: Either of the `fileData` and `fileURL` should not be `nil`, and the `fileName` and `mimeType` must both be `nil` or assigned at the same time,

///-----------------------------------------------------
/// @name Quickly Class Methods For Creates A New Object
///-----------------------------------------------------

+ (instancetype)formDataWithName:(NSString *)name fileData:(NSData *)fileData;
+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData;
+ (instancetype)formDataWithName:(NSString *)name fileURL:(NSURL *)fileURL;
+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL;

@end

NS_ASSUME_NONNULL_END
