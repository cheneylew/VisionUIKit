//
//  VSTBBaseController.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSTableAdaptor.h"

@class VSTableView;
@interface VSBaseTableViewController : UIViewController
<VSTableAdaptorDelegate>

@property (nonatomic, strong) VSTableView *TB;
@property (nonatomic, strong) VSTableAdaptor *TBDelegate;
@property (nonatomic, strong) VSBaseDataConstructor *TBConstructor;

- (NSString *)vs_constructorClassName;

@end
