//
//  VSMVVMViewModel.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/11.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSMVVMViewModel.h"

@interface VSMVVMViewModel()

PP_STRONG(VSMVVMModel, model)

@end

@implementation VSMVVMViewModel

- (void)viewButtonClick {
    self.model.userName = [NSString stringWithFormat:@"abc %d", arc4random()];
    self.labelText = self.model.userName;
}

- (void)setModel:(VSMVVMModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.labelText = _model.userName;
}

- (void)dealloc
{
    NSLog(@"VSMVVMViewModel dealloc");
}

@end
