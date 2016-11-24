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
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) BOOL hasNext;
- (void) loadData;
- (void) loadMore;
- (BOOL) isDelegateValid;
@end


@protocol NVNetworkDataConstructorDelegate <NSObject>

@optional
- (void) networkDataContructorStartLoading:(NVNetworkDataConstructor*)dataConstructor;
- (void) networkDataContructor:(NVNetworkDataConstructor*)dataConstructor didFinishWithData:(id)data;
- (void) networkDataContructor:(NVNetworkDataConstructor*)dataConstructor didErrorWithData:(id)data;
@end




