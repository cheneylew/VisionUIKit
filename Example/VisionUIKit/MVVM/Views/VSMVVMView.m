//
//  VSMVVMView.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/11.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSMVVMView.h"
#import <FBKVOController/KVOController.h>
#import <KKCategories/KKCategories.h>
#import "VSMVVMViewModel.h"

@interface VSMVVMView()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

PP_STRONG(VSMVVMViewModel, mvvmViewModel);

@end

@implementation VSMVVMView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 40)];
        self.label = label;
        [self addSubview:self.label];
        
        WEAK_SELF;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(100, 100, 80, 30);
        [button setTitle:@"点击" forState:UIControlStateNormal];
        [button jk_addActionHandler:^(NSInteger tag) {
            [weakself buttonClick];
        }];
        self.button = button;
        [self addSubview:self.button];
    }
    return self;
}

- (void)buttonClick {
    [self.mvvmViewModel viewButtonClick];
}

- (void)setViewModel:(VSMVVMViewModel *)viewModel {
    self.mvvmViewModel = viewModel;
    WEAK_SELF;
    [self.KVOController observe:viewModel keyPath:@"labelText" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        weakself.label.text = [change jk_stringForKey:NSKeyValueChangeNewKey];
    }];
}

- (void)dealloc
{
    NSLog(@"VSMVVMView dealloc");
}


@end
