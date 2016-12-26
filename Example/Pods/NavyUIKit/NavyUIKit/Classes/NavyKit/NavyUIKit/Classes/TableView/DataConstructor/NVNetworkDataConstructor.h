//
//  NVNetworkDataConstructor.h
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewDataConstructor.h"


@protocol NVNetworkDataConstructorDelegate;


@interface NVNetworkDataConstructor : NVTableViewDataConstructor
@property (nonatomic, weak) id<NVNetworkDataConstructorDelegate> delegate;
@property (nonatomic, strong) NVListModel *list;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) BOOL hasNext;

/**
 子类复写
 */
- (void) loadData;
- (void) loadMore;
- (BOOL) isDelegateValid;


/**
 提供给子类安全调用NVNetworkDataConstructorDelegate,不用Override
 */
- (void) nv_responseSuccess:(id) data;
- (void) nv_responseError:(id) error;
@end


@protocol NVNetworkDataConstructorDelegate <NSObject>

@optional
- (void) networkDataContructorStartLoading:(NVNetworkDataConstructor*)dataConstructor;
- (void) networkDataContructor:(NVNetworkDataConstructor*)dataConstructor didFinishWithData:(id)data;
- (void) networkDataContructor:(NVNetworkDataConstructor*)dataConstructor didErrorWithData:(id)data;
@end




