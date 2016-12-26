//
//  DJEngine.h
//  DJNetworking
//
//  Created by Dejun Liu on 12/12/2016.
//  Copyright © 2016 DJNetworking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DJRequest, AFHTTPSessionManager;

/**
 The completion handler block for a network request.
 
 @param responseObject The response object created by the response serializer.
 @param error The error describing the network or parsing error that occurred.
 */
typedef void (^DJCompletionHandler) (id _Nullable responseObject, NSError * _Nullable error);

/**
 `DJEngine` is a global engine to lauch the all network requests, which package the API of `AFNetworking`.
 */
@interface DJEngine : NSObject

/* Forbids to create a new `DJEngine` object, uses `[DJEngine sharedEngine]` instead. */
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Returns the default shared `DJEngine` singleton object.
 */
+ (instancetype)sharedEngine;

/**
 The `AFHTTPSessionManager` object retain by `[DJEngine sharedEngine]`, which used to lauch network request, you can custom the features for session manager.
 See `AFHTTPSessionManager.h` and `AFURLSessionManager.h` for details.
 */
@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

/**
 Runs a real network reqeust with a `DJRequest` object and completion handler block.
 
 @param request The `DJRequest` object to be launched.
 @param completionHandler The completion handler block for network response callback.
 @return Unique identifier for the passed in `DJRequest` object.
 */
- (NSUInteger)sendRequest:(DJRequest *)request
        completionHandler:(nullable DJCompletionHandler)completionHandler;

/**
 Method to cancel a runnig request by identifier
 
 @param identifier The unique identifier of a running request.
 @return return The canceled request object (if exist) matching to identifier.
 */
- (nullable DJRequest *)cancelRequestByIdentifier:(NSUInteger)identifier;

/**
 Method to get a runnig request object matching to identifier.
 
 @param identifier The unique identifier of a running request.
 @return return The runing requset object (if exist) matching to identifier.
 */
- (nullable DJRequest *)getRequestByIdentifier:(NSUInteger)identifier;

/**
 Method to get the current network reachablity status, see `AFNetworkReachabilityManager.h` for details.

 @return Network reachablity status code
 */
- (NSInteger)networkReachability;

@end

NS_ASSUME_NONNULL_END
