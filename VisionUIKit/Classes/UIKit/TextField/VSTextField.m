//
//  VSTextField.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTextField.h"

@interface VSTextField ()

@property (nonatomic, assign) UIEdgeInsets edgeMagin;

@end

@implementation VSTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeMagin = UIEdgeInsetsMake(2, 5, 2, 5);
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(_edgeMagin.left,
                      _edgeMagin.top,
                      bounds.size.width-_edgeMagin.left-_edgeMagin.right,
                      bounds.size.height-_edgeMagin.top-_edgeMagin.bottom);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(_edgeMagin.left,
                      _edgeMagin.top,
                      bounds.size.width-_edgeMagin.left-_edgeMagin.right,
                      bounds.size.height-_edgeMagin.top-_edgeMagin.bottom);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(_edgeMagin.left,
                      _edgeMagin.top,
                      bounds.size.width-_edgeMagin.left-_edgeMagin.right,
                      bounds.size.height-_edgeMagin.top-_edgeMagin.bottom);
}


/** 通过这个属性名，就可以修改textField内部的占位文字颜色 */
static NSString * const LXPlaceholderColorKeyPath = @"placeholderLabel.textColor";
static NSString * const LXPlaceholderFontKeyPath = @"_placeholderLabel.font";

/**
 *  设置占位文字颜色
 */
- (void)setVs_placeholderColor:(UIColor *)vs_placeholderColor
{
    // 这3行代码的作用：1> 保证创建出placeholderLabel，2> 保留曾经设置过的占位文字
    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    
    // 处理xmg_placeholderColor为nil的情况：如果是nil，恢复成默认的占位文字颜色
    if (vs_placeholderColor == nil) {
        vs_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:vs_placeholderColor forKeyPath:LXPlaceholderColorKeyPath];
}

/**
 *  获得占位文字颜色
 */
- (UIColor *)lx_placeholderColor
{
    return [self valueForKeyPath:LXPlaceholderColorKeyPath];
}

- (void)setVs_placeholderFont:(UIFont *)vs_placeholderFont {
    [self setValue:vs_placeholderFont forKeyPath:LXPlaceholderFontKeyPath];
}

- (UIFont *)vs_placeholderFont {
    return [self valueForKey:LXPlaceholderFontKeyPath];
}

@end
