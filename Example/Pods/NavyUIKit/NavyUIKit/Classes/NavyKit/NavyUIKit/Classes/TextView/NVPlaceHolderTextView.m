//
//  NVPlaceHolderTextView.m
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVPlaceHolderTextView.h"



@interface NVPlaceHolderTextView ()
@property (nonatomic, strong) UILabel* uiPlaceHolder;
- (void) textChanged:(NSNotification*)notification;
- (void) notifierKeyboardWillShow:(NSNotification*)notification;
- (void) notifierKeyboardWillHide:(NSNotification*)notification;
@end


@implementation NVPlaceHolderTextView

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierKeyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierKeyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textChanged:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:nil];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if ([_placeHolder length] > 0) {
        
        if (_uiPlaceHolder == nil ) {
            
            _uiPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 8.0f, self.bounds.size.width - 16, 0.0f)];
            _uiPlaceHolder.numberOfLines = 0;
            [_uiPlaceHolder setFont:self.font];
            [_uiPlaceHolder setBackgroundColor:[UIColor clearColor]];
            _uiPlaceHolder.textColor = [UIColor lightGrayColor];
            _uiPlaceHolder.alpha = 0;
            [self addSubview:_uiPlaceHolder];
        }
        
        [_uiPlaceHolder setText:_placeHolder];
        [_uiPlaceHolder sizeToFit];
        [self sendSubviewToBack:_uiPlaceHolder];
    }
    
    if ([self.text length] == 0 && [_placeHolder length] > 0) {
        _uiPlaceHolder.alpha = 1.0f;
    }
    
    [super drawRect:rect];
}

- (void) setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}


- (void) textChanged:(NSNotification*)notification {
    
    if ([_placeHolder length] == 0) {
        return;
    }
    
    [_uiPlaceHolder setAlpha:([self.text length] == 0)];
    
}

- (void) notifierKeyboardWillShow:(NSNotification*)notification {
    
    UIWindow* keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView* firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    if (![firstResponder isEqual:self]) {
        return;
    }
    
    UIView* view = nil;
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
        
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        NSDictionary *info                   = notification.userInfo;
        CGRect screenFrame                   = [tableView.superview convertRect:tableView.frame
                                                                         toView:[UIApplication sharedApplication].keyWindow];
        CGFloat tableViewBottomOnScreen      = screenFrame.origin.y + screenFrame.size.height;
        CGFloat tableViewGap                 = screenHeight - tableViewBottomOnScreen;
        CGSize keyboardSize                  = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        UIEdgeInsets contentInsets           = UIEdgeInsetsMake(0, 0, keyboardSize.height - tableViewGap, 0);
        contentInsets.top                    = 70.0f;
        
        // Prepare for the animation
        CGFloat animationDuration            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
        NSUInteger animationCurve            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]).intValue;
        
        
        
        [UIView animateWithDuration:animationDuration
                              delay:0.25f
                            options:animationCurve
                         animations: ^{
                             tableView.contentInset          = contentInsets;
                             tableView.scrollIndicatorInsets = contentInsets;
                             tableView.contentOffset         = CGPointMake(0.0f, -70.0f);
                         }
         
                         completion:nil];
    }
    
    
}

- (void) notifierKeyboardWillHide:(NSNotification*)notification {
    
    UIView* view = nil;
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
        
        UIEdgeInsets contentInsets           = UIEdgeInsetsZero;
        contentInsets.top                    = 70.0f;
        NSDictionary *info                   = notification.userInfo;
        // Prepare for the animation
        CGFloat animationDuration            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
        NSUInteger animationCurve            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]).intValue;
        
        [UIView animateWithDuration:animationDuration
                              delay:0.25f
                            options:animationCurve
                         animations: ^{
                             tableView.contentInset          = contentInsets;
                             tableView.scrollIndicatorInsets = contentInsets;
                             tableView.contentOffset         = CGPointMake(0.0f, -70.0f);
                         }
         
                         completion:nil];
        
    }
}



@end
