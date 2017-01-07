//
//  VSTBBaseController.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSTableAdaptor.h"
#import "VSBaseViewController.h"
#import "VSNetworkDataConstructor.h"

@class VSTableView;
@interface VSBaseTableViewController : VSBaseViewController
<VSTableAdaptorDelegate>

@property (nonatomic, strong)   VSTableView *TB;
@property (nonatomic, strong)   VSTableAdaptor *TBDelegate;
@property (nonatomic, strong)   VSNormalDataConstructor *TBConstructor;

/**
 若TBConstructor是一个VSNetworkDataConstructor，则TBNetworkConstructor以指针方式指向TBConstructor。
 方便子类可以使用TBNetworkConstructor来快速代码提示vs_loadData的方法。
 */
@property (nonatomic, weak)     VSNetworkDataConstructor *TBNetworkConstructor;

- (void)vs_reloadAllData;
- (void)vs_reloadIndex:(NSUInteger) index;
- (void)vs_reloadIndexPath:(NSIndexPath *) indexPath;
- (void)vs_reloadIndexPaths:(NSArray<NSIndexPath *> *) indexPaths;

- (Class )vs_constructorClass;
- (void)vs_constructorData;

@end
