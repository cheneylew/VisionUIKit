//
//  VSTextField.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTextField.h"

@interface VSTextField () {
    UIEdgeInsets _tableViewEdgeInsets;
    BOOL _keyboardShowing;
}

@property (nonatomic, assign) UIEdgeInsets edgeMagin;

@end

@implementation VSTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeMagin = UIEdgeInsetsMake(2, 5, 2, 5);
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierKeyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierKeyboardWillHide:) name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        self.inputAccessoryView = [self generateToolbar];
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

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (UIView*) generateToolbar {
    UIView* toolbar         = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    toolbar.backgroundColor = [UIColor whiteColor];
    
    UIView* topLine             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, toolbar.bounds.size.width, 0.5)];
    topLine.backgroundColor     = [UIColor lightGrayColor];
    topLine.autoresizingMask    = UIViewAutoresizingFlexibleWidth;
    [toolbar addSubview:topLine];
    
    UIButton *finishedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [finishedButton setTitle:@"完成" forState:UIControlStateNormal];
    finishedButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [finishedButton addTarget:self action:@selector(doneButtonDidPressed:)
             forControlEvents:UIControlEventTouchUpInside];
    finishedButton.frame = CGRectMake(toolbar.frame.size.width - 64 - 10, 0, 64, 44);
    finishedButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [finishedButton setTitleColor:[UIColor colorWithRed:11/255.0f green:46/255.0f blue:84/255.0f alpha:1]
                         forState:UIControlStateNormal];
    
    [toolbar addSubview:finishedButton];
    [topLine bringSubviewToFront:topLine];
    return toolbar;
}

- (void) doneButtonDidPressed:(id)sender {
    if (self.doneDelegate && [self.doneDelegate respondsToSelector:@selector(textFieldDidPressedDone:)]) {
        [self.doneDelegate textFieldDidPressedDone:sender];
    }
    [self resignFirstResponder];
}

- (BOOL) canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:) ||
        action == @selector(paste:) ||
        action == @selector(select:) ||
        action == @selector(selectAll:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (void) notifierKeyboardWillShow:(NSNotification*)notification {
    
    UIWindow* keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView* firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    if (![firstResponder isEqual:self]) {
        return;
    }
    
    if (_keyboardShowing) {
        return;
    }else {
        _keyboardShowing = YES;
    }
    
    UIView* subView = nil;
    if ([NSStringFromClass(self.superview.class) isEqualToString:@"UITableViewCellContentView"]) {
        subView = self.superview.superview.superview;
        while (subView != nil) {
            if ([subView.superview isKindOfClass:[UITableView class]]) {
                subView = subView.superview;
                break;
            }
            subView = subView.superview;
        }
        UITableView* tableView = (UITableView*)subView;
        _tableViewEdgeInsets = tableView.contentInset;
        
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        NSDictionary *info                   = notification.userInfo;
        CGRect screenFrame                   = [tableView.superview convertRect:tableView.frame
                                                                         toView:[UIApplication sharedApplication].keyWindow];
        CGFloat tableViewBottomOnScreen      = screenFrame.origin.y + screenFrame.size.height;
        CGFloat tableViewGap                 = screenHeight - tableViewBottomOnScreen;
        CGSize keyboardSize                  = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets           = tableView.contentInset;
        contentInsets.bottom                 = keyboardSize.height - tableViewGap;
        
        CGFloat animationDuration            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
        NSUInteger animationCurve            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]).intValue;
        
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:animationCurve
                         animations: ^{
                             tableView.contentInset          = contentInsets;
                             tableView.scrollIndicatorInsets = contentInsets;
                         }
         
                         completion:nil];
    }
}

- (void) notifierKeyboardWillHide:(NSNotification*)notification {
    
    if (!_keyboardShowing) {
        return;
    }else {
        _keyboardShowing = NO;
    }
    
    UIView* subView = nil;
    if ([NSStringFromClass(self.superview.class) isEqualToString:@"UITableViewCellContentView"]) {
        subView = self.superview.superview.superview;
        while (subView != nil) {
            if ([subView.superview isKindOfClass:[UITableView class]]) {
                subView = subView.superview;
                break;
            }
            subView = subView.superview;
        }
        UITableView* tableView = (UITableView*)subView;
        
        UIEdgeInsets contentInsets           = _tableViewEdgeInsets;
        NSDictionary *info                   = notification.userInfo;
        
        CGFloat animationDuration            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
        NSUInteger animationCurve            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]).intValue;
        
        [UIView animateWithDuration:animationDuration
                              delay:0.25f
                            options:animationCurve
                         animations: ^{
                             tableView.contentInset          = contentInsets;
                             tableView.scrollIndicatorInsets = contentInsets;
                         }
                         completion:^(BOOL finished) {
                             _tableViewEdgeInsets = UIEdgeInsetsZero;
                         }];
        
    }
}


@end
