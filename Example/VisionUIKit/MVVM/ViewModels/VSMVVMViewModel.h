//
//  VSMVVMViewModel.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/11.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>
#import "VSMVVMModel.h"

@interface VSMVVMViewModel : NSObject

PP_STRONG(NSString, labelText)          //文字改变，视图也跟着改变
- (void)viewButtonClick;                //view的事件，这里面更新Model的值
- (void)setModel:(VSMVVMModel *)model;  //设置目标Model

@end
