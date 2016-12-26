//
//  DJRequest.m
//  DJNetworking
//
//  Created by Dejun Liu on 12/12/2016.
//  Copyright © 2016 DJNetworking. All rights reserved.
//

#import "DJRequest.h"
#import "DJCenter.h"

@interface DJRequest ()

@end

@implementation DJRequest

+ (instancetype)request {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // Set default value for DJRequest instance
    _requestType = kDJRequestNormal;
    _httpMethod = kDJHTTPMethodPOST;
    _requestSerializerType = kDJRequestSerializerRAW;
    _responseSerializerType = kDJResponseSerializerJSON;
    _timeoutInterval = 60.0;
    
    _useGeneralServer = YES;
    _useGeneralHeaders = YES;
    _useGeneralParameters = YES;
    
    _retryCount = 0;
    _identifier = 0;
    
    return self;
}

- (void)cleanCallbackBlocks {
    _successBlock = nil;
    _failureBlock = nil;
    _finishedBlock = nil;
    _progressBlock = nil;
}

- (NSMutableArray<DJUploadFormData *> *)uploadFormDatas {
    if (!_uploadFormDatas) {
        _uploadFormDatas = [NSMutableArray array];
    }
    return _uploadFormDatas;
}

- (void)addFormDataWithName:(NSString *)name fileData:(NSData *)fileData {
    DJUploadFormData *formData = [DJUploadFormData formDataWithName:name fileData:fileData];
    [self.uploadFormDatas addObject:formData];
}

- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData {
    DJUploadFormData *formData = [DJUploadFormData formDataWithName:name fileName:fileName mimeType:mimeType fileData:fileData];
    [self.uploadFormDatas addObject:formData];
}

- (void)addFormDataWithName:(NSString *)name fileURL:(NSURL *)fileURL {
    DJUploadFormData *formData = [DJUploadFormData formDataWithName:name fileURL:fileURL];
    [self.uploadFormDatas addObject:formData];
}

- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL {
    DJUploadFormData *formData = [DJUploadFormData formDataWithName:name fileName:fileName mimeType:mimeType fileURL:fileURL];
    [self.uploadFormDatas addObject:formData];
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

@end

#pragma mark - DJBatchRequest

@interface DJBatchRequest () {
    dispatch_semaphore_t _lock;
    NSUInteger _finishedCount;
    BOOL _failed;
}

@property (nonatomic, copy) DJBatchSuccessBlock batchSuccessBlock;
@property (nonatomic, copy) DJBatchFailureBlock batchFailureBlock;
@property (nonatomic, copy) DJBatchFinishedBlock batchFinishedBlock;

@end

@implementation DJBatchRequest

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _failed = NO;
    _finishedCount = 0;
    _lock = dispatch_semaphore_create(1);

    _requestArray = [NSMutableArray array];
    _responseArray = [NSMutableArray array];
    
    return self;
}

- (void)onFinishedOneRequest:(DJRequest *)request response:(id)responseObject error:(NSError *)error {
    DJLock();
    NSUInteger index = [_requestArray indexOfObject:request];
    if (responseObject) {
        [_responseArray replaceObjectAtIndex:index withObject:responseObject];
    } else {
        _failed = YES;
        if (error) {
            [_responseArray replaceObjectAtIndex:index withObject:error];
        }
    }
    
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        if (!_failed) {
            DJ_SAFE_BLOCK(_batchSuccessBlock, _responseArray);
            DJ_SAFE_BLOCK(_batchFinishedBlock, _responseArray, nil);
        } else {
            DJ_SAFE_BLOCK(_batchFailureBlock, _responseArray);
            DJ_SAFE_BLOCK(_batchFinishedBlock, nil, _responseArray);
        }
        [self cleanCallbackBlocks];
    }
    DJUnlock();
}

- (void)cleanCallbackBlocks {
    _batchSuccessBlock = nil;
    _batchFailureBlock = nil;
    _batchFinishedBlock = nil;
}

- (void)cancelWithBlock:(void (^)())cancelBlock {
    if (_requestArray.count > 0) {
        [_requestArray enumerateObjectsUsingBlock:^(DJRequest *obj, NSUInteger idx, __unused BOOL *stop) {
            if (obj.identifier > 0) {
                [DJCenter cancelRequest:obj.identifier];
            }
        }];
    }
    DJ_SAFE_BLOCK(cancelBlock);
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

@end

#pragma mark - DJChainRequest

@interface DJChainRequest () {
    NSUInteger _chainIndex;
}

@property (nonatomic, strong, readwrite) DJRequest *firstRequest;
@property (nonatomic, strong, readwrite) DJRequest *nextRequest;

@property (nonatomic, strong) NSMutableArray<DJChainNextBlock> *nextBlockArray;
@property (nonatomic, strong) NSMutableArray<id> *responseArray;

@property (nonatomic, copy) DJBatchSuccessBlock chainSuccessBlock;
@property (nonatomic, copy) DJBatchFailureBlock chainFailureBlock;
@property (nonatomic, copy) DJBatchFinishedBlock chainFinishedBlock;

@end

@implementation DJChainRequest : NSObject

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _chainIndex = 0;
    _responseArray = [NSMutableArray array];
    _nextBlockArray = [NSMutableArray array];
    
    return self;
}

- (DJChainRequest *)onFirst:(DJRequestConfigBlock)firstBlock {
    NSAssert(firstBlock != nil, @"The first block for chain requests can't be nil.");
    NSAssert(_nextBlockArray.count == 0, @"The `onFirst:` method must called befault `onNext:` method");
    _firstRequest = [DJRequest request];
    firstBlock(_firstRequest);
    [_responseArray addObject:[NSNull null]];
    return self;
}

- (DJChainRequest *)onNext:(DJChainNextBlock)nextBlock {
    NSAssert(nextBlock != nil, @"The next block for chain requests can't be nil.");
    [_nextBlockArray addObject:nextBlock];
    [_responseArray addObject:[NSNull null]];
    return self;
}

- (void)onFinishedOneRequest:(DJRequest *)request response:(id)responseObject error:(NSError *)error {
    if (responseObject) {
        [_responseArray replaceObjectAtIndex:_chainIndex withObject:responseObject];
        if (_chainIndex < _nextBlockArray.count) {
            _nextRequest = [DJRequest request];
            DJChainNextBlock nextBlock = _nextBlockArray[_chainIndex];
            BOOL startNext = YES;
            nextBlock(_nextRequest, responseObject, &startNext);
            if (!startNext) {
                DJ_SAFE_BLOCK(_chainFailureBlock, _responseArray);
                DJ_SAFE_BLOCK(_chainFinishedBlock, nil, _responseArray);
                [self cleanCallbackBlocks];
            }
        } else {
            DJ_SAFE_BLOCK(_chainSuccessBlock, _responseArray);
            DJ_SAFE_BLOCK(_chainFinishedBlock, nil, _responseArray);
            [self cleanCallbackBlocks];
        }
    } else {
        if (error) {
            [_responseArray replaceObjectAtIndex:_chainIndex withObject:error];
        }
        DJ_SAFE_BLOCK(_chainFailureBlock, _responseArray);
        DJ_SAFE_BLOCK(_chainFinishedBlock, nil, _responseArray);
        [self cleanCallbackBlocks];
    }
    _chainIndex++;
}

- (void)cleanCallbackBlocks {
    _firstRequest = nil;
    _nextRequest = nil;
    _chainSuccessBlock = nil;
    _chainFailureBlock = nil;
    _chainFinishedBlock = nil;
    [_nextBlockArray removeAllObjects];
}

- (void)cancelWithBlock:(void (^)())cancelBlock {
    if (_firstRequest && !_nextRequest) {
        [DJCenter cancelRequest:_firstRequest.identifier];
    } else if (_nextRequest) {
        [DJCenter cancelRequest:_nextRequest.identifier];
    }
    DJ_SAFE_BLOCK(cancelBlock);
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

@end

#pragma mark - DJUploadFormData

@implementation DJUploadFormData

+ (instancetype)formDataWithName:(NSString *)name fileData:(NSData *)fileData {
    DJUploadFormData *formData = [[DJUploadFormData alloc] init];
    formData.name = name;
    formData.fileData = fileData;
    return formData;
}

+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData {
    DJUploadFormData *formData = [[DJUploadFormData alloc] init];
    formData.name = name;
    formData.fileName = fileName;
    formData.mimeType = mimeType;
    formData.fileData = fileData;
    return formData;
}

+ (instancetype)formDataWithName:(NSString *)name fileURL:(NSURL *)fileURL {
    DJUploadFormData *formData = [[DJUploadFormData alloc] init];
    formData.name = name;
    formData.fileURL = fileURL;
    return formData;
}

+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL {
    DJUploadFormData *formData = [[DJUploadFormData alloc] init];
    formData.name = name;
    formData.fileName = fileName;
    formData.mimeType = mimeType;
    formData.fileURL = fileURL;
    return formData;
}

@end
