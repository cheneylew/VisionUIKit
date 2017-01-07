//
//  VSNetworkDataConstructor.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/4.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSNormalDataConstructor.h"
#import "VSDataModel.h"

@class VSNetworkDataConstructor;
@protocol VSNetworkDataConstructorDelegate <NSObject>

@optional
- (void) vs_networkDataContructorStartLoading:(VSNetworkDataConstructor *)dataConstructor;
- (void) vs_networkDataContructor:(VSNetworkDataConstructor *)dataConstructor didFinishWithData:(id)data;
- (void) vs_networkDataContructor:(VSNetworkDataConstructor *)dataConstructor didErrorWithData:(id)data;
@end

@interface VSNetworkDataConstructor : VSNormalDataConstructor

@property (nonatomic, weak) id<VSNetworkDataConstructorDelegate> delegate;
@property (nonatomic, strong) VSListModel *list;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) BOOL hasNext;

// override
- (void)vs_loadData;
- (void)vs_loadMore;
- (BOOL)vs_isDelegateValid;

/**
 提供给子类安全调用NVNetworkDataConstructorDelegate,不用Override
 */
- (void)vs_callDelegateSuccess:(id) data;
- (void)vs_callDelegateError:(id) error;
- (void)vs_callDelegateShouldStartLoading;

@end
