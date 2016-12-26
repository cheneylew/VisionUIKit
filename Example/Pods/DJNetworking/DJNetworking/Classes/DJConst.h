//
//  DJConst.h
//  DJNetworking
//
//  Created by Dejun Liu on 12/12/2016.
//  Copyright © 2016 DJNetworking. All rights reserved.
//

#ifndef DJConst_h
#define DJConst_h

#define DJ_SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })
#define DJLock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define DJUnlock() dispatch_semaphore_signal(self->_lock)

NS_ASSUME_NONNULL_BEGIN

@class DJRequest, DJBatchRequest, DJChainRequest;

/**
 Types enum for DJRequest.
 */
typedef NS_ENUM(NSInteger, DJRequestType) {
    kDJRequestNormal    = 0,    //!< Normal HTTP request type, such as GET, POST, ...
    kDJRequestUpload    = 1,    //!< Upload request type
    kDJRequestDownload  = 2,    //!< Download request type
};

/**
 HTTP methods enum for DJRequest.
 */
typedef NS_ENUM(NSInteger, DJHTTPMethodType) {
    kDJHTTPMethodGET    = 0,    //!< GET
    kDJHTTPMethodPOST   = 1,    //!< POST
    kDJHTTPMethodHEAD   = 2,    //!< HEAD
    kDJHTTPMethodDELETE = 3,    //!< DELETE
    kDJHTTPMethodPUT    = 4,    //!< PUT
    kDJHTTPMethodPATCH  = 5,    //!< PATCH
};

/**
 Resquest parameter serialization type enum for DJRequest, see `AFURLRequestSerialization.h` for details.
 */
typedef NS_ENUM(NSInteger, DJRequestSerializerType) {
    kDJRequestSerializerRAW     = 0,    //!< Encodes parameters to a query string and put it into HTTP body, setting the `Content-Type` of the encoded request to default value `application/x-www-form-urlencoded`.
    kDJRequestSerializerJSON    = 1,    //!< Encodes parameters as JSON using `NSJSONSerialization`, setting the `Content-Type` of the encoded request to `application/json`.
    kDJRequestSerializerPlist   = 2,    //!< Encodes parameters as Property List using `NSPropertyListSerialization`, setting the `Content-Type` of the encoded request to `application/x-plist`.
};

/**
 Response data serialization type enum for DJRequest, see `AFURLResponseSerialization.h` for details.
 */
typedef NS_ENUM(NSInteger, DJResponseSerializerType) {
    kDJResponseSerializerRAW    = 0,    //!< Validates the response status code and content type, and returns the default response data.
    kDJResponseSerializerJSON   = 1,    //!< Validates and decodes JSON responses using `NSJSONSerialization`, and returns a NSDictionary/NSArray/... JSON object.
    kDJResponseSerializerPlist  = 2,    //!< Validates and decodes Property List responses using `NSPropertyListSerialization`, and returns a property list object.
    kDJResponseSerializerDJL    = 3,    //!< Validates and decodes DJL responses as an `NSDJLParser` objects.
};

///------------------------------
/// @name DJRequest Config Blocks
///------------------------------

typedef void (^DJRequestConfigBlock)(DJRequest *request);
typedef void (^DJBatchRequestConfigBlock)(DJBatchRequest *batchRequest);
typedef void (^DJChainRequestConfigBlock)(DJChainRequest *chainRequest);

///--------------------------------
/// @name DJRequest Callback Blocks
///--------------------------------

typedef void (^DJProgressBlock)(NSProgress *progress);
typedef void (^DJSuccessBlock)(id _Nullable responseObject);
typedef void (^DJFailureBlock)(NSError * _Nullable error);
typedef void (^DJFinishedBlock)(id _Nullable responseObject, NSError * _Nullable error);
typedef void (^DJCancelBlock)(DJRequest * _Nullable request);

typedef void (^DJBatchSuccessBlock)(NSArray<id> *responseObjects);
typedef void (^DJBatchFailureBlock)(NSArray<id> *errors);
typedef void (^DJBatchFinishedBlock)(NSArray<id> * _Nullable responseObjects, NSArray<id> * _Nullable errors);

typedef void (^DJChainNextBlock)(DJRequest *request, id _Nullable responseObject, BOOL *sendNext);

///--------------------------------------
/// @name DJCenter Response Process Block
///--------------------------------------

/**
 The custom response process block for all DJRequests invoked by DJCenter.

 @param request The current DJRequest object
 @param responseObject The response data return from server.
 @param error The error that occurred while the response data don't conforms to your own business logic.
 */
typedef void (^DJCenterResponseProcessBlock)(DJRequest *request, id _Nullable responseObject, NSError * _Nullable __autoreleasing *error);

NS_ASSUME_NONNULL_END

#endif /* DJConst_h */
