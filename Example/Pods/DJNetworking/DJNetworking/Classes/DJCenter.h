//
//  DJCenter.h
//  DJNetworking
//
//  Created by Dejun Liu on 12/12/2016.
//  Copyright © 2016 DJNetworking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJConst.h"

NS_ASSUME_NONNULL_BEGIN

@class DJConfig;

/**
 `DJCenter` is a global central place to send and manage network requests.
 `+center` method is used to creates a new `DJCenter` object,
 `+defaultCenter` method will return a default shared `DJCenter` singleton object.
 
 The class methods for `DJCenter` are invoked by `[DJCenter defaultCenter]`, which are recommend to use `Class Method` instead of manager a `DJCenter` yourself.
 
 Usage:
 
 (1) Config DJCenter
 
 [DJCenter setupConfig:^(DJConfig *config) {
     config.server = @"general server address";
     config.headers = @{@"general header": @"general header value"};
     config.parameters = @{@"general parameter": @"general parameter value"};
     config.callbackQueue = dispatch_get_main_queue(); // set callback dispatch queue
 }];
 
 [DJCenter setResponseProcessBlock:^(DJRequest *request, id responseObject, NSError *__autoreleasing *error) {
     // Do the custom response data processing logic by yourself,
     // You can assign the passed in `error` argument when error occurred, and the failure block will be called instead of success block.
 }];
 
 (2) Send a Request
 
 [DJCenter sendRequest:^(DJRequest *request) {
     request.server = @"server address"; // optional, if `nil`, the genneal server is used.
     request.api = @"api path";
     request.parameters = @{@"param1": @"value1", @"param2": @"value2"}; // and the general parameters will add to reqeust parameters.
 } onSuccess:^(id responseObject) {
     // success code here...
 } onFailure:^(NSError *error) {
     // failure code here...
 }];
 
 */
@interface DJCenter : NSObject

///---------------------
/// @name Initialization
///---------------------

/**
 Creates and returns a new `DJCenter` object.
 */
+ (instancetype)center;

/**
 Returns the default shared `DJCenter` singleton object.
 */
+ (instancetype)defaultCenter;

///-----------------------
/// @name General Property
///-----------------------

// NOTE: The following properties will be assigned by `DJConfig` through invoking `-setupConfig:` method.

/**
 The general server address for DJCenter, if DJRequest.server is `nil` and the DJRequest.useGeneralServer is `YES`, this property will be assigned to DJRequest.server.
 */
@property (nonatomic, copy, nullable, readonly) NSString *generalServer;

/**
 The general parameters for DJCenter, if DJRequest.useGeneralParameters is `YES` and this property is not empty, it will be appended to DJRequest.parameters.
 */
@property (nonatomic, strong, nullable, readonly) NSMutableDictionary<NSString *, id> *generalParameters;

/**
 The general headers for DJCenter, if DJRequest.useGeneralHeaders is `YES` and this property is not empty, it will be appended to DJRequest.headers.
 */
@property (nonatomic, strong, nullable, readonly) NSMutableDictionary<NSString *, NSString *> *generalHeaders;

/**
 The general user info for DJCenter, if DJRequest.userInfo is `nil` and this property is not `nil`, it will be assigned to DJRequest.userInfo.
 */
@property (nonatomic, strong, nullable) NSDictionary *generalUserInfo;

/**
 The dispatch queue for callback blocks. If `NULL` (default), a private concurrent queue is used.
 */
@property (nonatomic, strong, nullable) dispatch_queue_t callbackQueue;

/**
 Whether to print the request and response info in console or not, `NO` by default.
 */
@property (nonatomic, assign) BOOL consoleLog;

///--------------------------------------------
/// @name Instance Method to Configure DJCenter
///--------------------------------------------

/**
 Method to config the DJCenter properties by a `DJConfig` object.

 @param block The config block to assign the values for `DJConfig` object.
 */
- (void)setupConfig:(void(^)(DJConfig *config))block;

/**
 Method to set custom response data processing block for DJCenter.

 @param block The custom processing block (`DJCenterResponseProcessBlock`).
 */
- (void)setResponseProcessBlock:(DJCenterResponseProcessBlock)block;

///---------------------------------------
/// @name Instance Method to Send Requests
///---------------------------------------

/**
 Creates and runs a Normal `DJRequest`.

 @param configBlock The config block to setup context info for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock;

/**
 Creates and runs a Normal `DJRequest` with success block.
 
 NOTE: The success block will be called on `callbackQueue` of DJCenter.

 @param configBlock The config block to setup context info for the new created DJRequest object.
 @param successBlock Success callback block for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock;

/**
 Creates and runs a Normal `DJRequest` with failure block.
 
 NOTE: The failure block will be called on `callbackQueue` of DJCenter.

 @param configBlock The config block to setup context info for the new created DJRequest object.
 @param failureBlock Failure callback block for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onFailure:(nullable DJFailureBlock)failureBlock;

/**
 Creates and runs a Normal `DJRequest` with finished block.

 NOTE: The finished block will be called on `callbackQueue` of DJCenter.
 
 @param configBlock The config block to setup context info for the new created DJRequest object.
 @param finishedBlock Finished callback block for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock;

/**
 Creates and runs a Normal `DJRequest` with success/failure blocks.

 NOTE: The success/failure blocks will be called on `callbackQueue` of DJCenter.
 
 @param configBlock The config block to setup context info for the new created DJRequest object.
 @param successBlock Success callback block for the new created DJRequest object.
 @param failureBlock Failure callback block for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock;

/**
 Creates and runs a Normal `DJRequest` with success/failure/finished blocks.

 NOTE: The success/failure/finished blocks will be called on `callbackQueue` of DJCenter.
 
 @param configBlock The config block to setup context info for the new created DJRequest object.
 @param successBlock Success callback block for the new created DJRequest object.
 @param failureBlock Failure callback block for the new created DJRequest object.
 @param finishedBlock Finished callback block for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock;

/**
 Creates and runs an Upload/Download `DJRequest` with progress/success/failure blocks.

 NOTE: The success/failure blocks will be called on `callbackQueue` of DJCenter.
 BUT !!! the progress block is called on the session queue, not the `callbackQueue` of DJCenter.
 
 @param configBlock The config block to setup context info for the new created DJRequest object.
 @param progressBlock Progress callback block for the new created DJRequest object.
 @param successBlock Success callback block for the new created DJRequest object.
 @param failureBlock Failure callback block for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock;

/**
 Creates and runs an Upload/Download `DJRequest` with progress/success/failure/finished blocks.

 NOTE: The success/failure/finished blocks will be called on `callbackQueue` of DJCenter.
 BUT !!! the progress block is called on the session queue, not the `callbackQueue` of DJCenter.
 
 @param configBlock The config block to setup context info for the new created DJRequest object.
 @param progressBlock Progress callback block for the new created DJRequest object.
 @param successBlock Success callback block for the new created DJRequest object.
 @param failureBlock Failure callback block for the new created DJRequest object.
 @param finishedBlock Finished callback block for the new created DJRequest object.
 @return Unique identifier for the new running DJRequest object,`0` for fail.
 */
- (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock;

/**
 Creates and runs batch requests

 @param configBlock The config block to setup batch requests context info for the new created DJBatchRequest object.
 @param successBlock Success callback block called when all batch requests finished successfully.
 @param failureBlock Failure callback block called once a request error occured.
 @param finishedBlock Finished callback block for the new created DJBatchRequest object.
 @return The new running DJBatchRequest object, the object might be used to cancel the batch requests.
 */
- (nullable DJBatchRequest *)sendBatchRequest:(DJBatchRequestConfigBlock)configBlock
                                    onSuccess:(nullable DJBatchSuccessBlock)successBlock
                                    onFailure:(nullable DJBatchFailureBlock)failureBlock
                                   onFinished:(nullable DJBatchFinishedBlock)finishedBlock;

/**
 Creates and runs chain requests

 @param configBlock The config block to setup chain requests context info for the new created DJBatchRequest object.
 @param successBlock Success callback block called when all chain requests finished successfully.
 @param failureBlock Failure callback block called once a request error occured.
 @param finishedBlock Finished callback block for the new created DJChainRequest object.
 @return The new running DJChainRequest object, the object might be used to cancel the chain requests.
 */
- (nullable DJChainRequest *)sendChainRequest:(DJChainRequestConfigBlock)configBlock
                                    onSuccess:(nullable DJBatchSuccessBlock)successBlock
                                    onFailure:(nullable DJBatchFailureBlock)failureBlock
                                   onFinished:(nullable DJBatchFinishedBlock)finishedBlock;

///---------------------------------------------------------
/// @name Class Method to Configure [DJCenter defaultCenter]
///---------------------------------------------------------

+ (void)setupConfig:(void(^)(DJConfig *config))block;
+ (void)setResponseProcessBlock:(DJCenterResponseProcessBlock)block;

/**
 Sets the value for the general HTTP headers of [DJCenter defaultCenter], If `nil`, removes the existing value for that header.

 @param value The value to set for the specified header, or `nil`.
 @param field The HTTP header to set a value for.
 */
+ (void)setGeneralHeaderValue:(nullable NSString *)value forField:(NSString *)field;

/**
 Sets the value for the general parameters of [DJCenter defaultCenter], If `nil`, removes the existing value for that parameter.

 @param value The value to set for the specified parameter, or `nil`.
 @param key The parameter key to set a value for.
 */
+ (void)setGeneralParameterValue:(nullable NSString *)value forKey:(NSString *)key;

///------------------------------------
/// @name Class Method to Send Requests
///------------------------------------

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock;

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock;

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onFailure:(nullable DJFailureBlock)failureBlock;

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock;

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock;

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock;

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock;

+ (NSUInteger)sendRequest:(DJRequestConfigBlock)configBlock
               onProgress:(nullable DJProgressBlock)progressBlock
                onSuccess:(nullable DJSuccessBlock)successBlock
                onFailure:(nullable DJFailureBlock)failureBlock
               onFinished:(nullable DJFinishedBlock)finishedBlock;

+ (nullable DJBatchRequest *)sendBatchRequest:(DJBatchRequestConfigBlock)configBlock
                                    onSuccess:(nullable DJBatchSuccessBlock)successBlock
                                    onFailure:(nullable DJBatchFailureBlock)failureBlock
                                   onFinished:(nullable DJBatchFinishedBlock)finishedBlock;

+ (nullable DJChainRequest *)sendChainRequest:(DJChainRequestConfigBlock)configBlock
                                    onSuccess:(nullable DJBatchSuccessBlock)successBlock
                                    onFailure:(nullable DJBatchFailureBlock)failureBlock
                                   onFinished:(nullable DJBatchFinishedBlock)finishedBlock;

///-------------------------------------------------------
/// @name Class Methods to Get Or Cancel a Running Request
///-------------------------------------------------------

/**
 Method to cancel a runnig request by identifier.

 @param identifier The unique identifier of a running request.
 */
+ (void)cancelRequest:(NSUInteger)identifier;

/**
 Method to cancel a runnig request by identifier with cancel block.
 
 NOTE: The cancel block is called on current thread who invoked the method, not the `callbackQueue` of DJCenter.
 
 @param identifier The unique identifier of a running request.
 @param cancelBlock The callback block to be executed after the running request is canceled. The canceled request object (if exist) will be passed in argument to the cancel block.
 */
+ (void)cancelRequest:(NSUInteger)identifier
             onCancel:(nullable DJCancelBlock)cancelBlock;

/**
 Method to get a runnig request object matching to identifier.
 
 @param identifier The unique identifier of a running request.
 @return return The runing requset object (if exist) matching to identifier.
 */
+ (nullable DJRequest *)getRequest:(NSUInteger)identifier;

/**
 Method to get current network reachablity status.

 @return The network is reachable or not.
 */
+ (BOOL)isNetworkReachable;

@end

#pragma mark - DJConfig

/**
 `DJConfig` is used to assign values for DJCenter through invoking `-setupConfig:` method.
 */
@interface DJConfig : NSObject

///-----------------------------------------------
/// @name Properties to Assign Values for DJCenter
///-----------------------------------------------

@property (nonatomic, copy, nullable) NSString *generalServer;
@property (nonatomic, strong, nullable) NSDictionary<NSString *, id> *generalParameters;
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSString *> *generalHeaders;
@property (nonatomic, strong, nullable) NSDictionary *generalUserInfo;
@property (nonatomic, strong, nullable) dispatch_queue_t callbackQueue;
@property (nonatomic, assign) BOOL consoleLog;

@end

NS_ASSUME_NONNULL_END
