//
//  VSTBBaseController.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSTBAdaptor.h"

@class VSTableView;
@interface VSTBBaseController : UIViewController
<VSTBAdaptorDelegate>

@property (nonatomic, strong) VSTableView *TB;
@property (nonatomic, strong) VSTBAdaptor *TBDelegate;
@property (nonatomic, strong) VSTBConstructor *TBConstructor;

- (NSString *)vs_constructorClassName;

@end
