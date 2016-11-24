//
//  NVTextField.m
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTextField.h"


@interface NVTextField ()
- (UIView*) generateToolbar;
- (void) doneButtonDidPressed:(id)sender;
- (void) notifierKeyboardWillShow:(NSNotification*)notification;
- (void) notifierKeyboardWillHide:(NSNotification*)notification;
@end


@implementation NVTextField

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifierKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifierKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        self.inputAccessoryView = [self generateToolbar];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

//控制placeHolder的颜色、字体
- (void) drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    [_placeHolderColor setFill];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary* attr = [NSDictionary dictionaryWithObjectsAndKeys:
                          style, NSParagraphStyleAttributeName,
                          self.font, NSFontAttributeName,
                          _placeHolderColor, NSForegroundColorAttributeName,
                          nil];
    
//    CGRect bounds   = self.bounds;
//    CGSize size     = [self.placeholder boundingRectWithSize:CGSizeMake(bounds.size.width, bounds.size.height)
//                                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                                  attributes:attr
//                                                     context:nil].size;
//    
//    if (self.textAlignment == NSTextAlignmentLeft ||
//        self.textAlignment == NSTextAlignmentCenter) {
//        rect.origin.x = 0.0f;
//    } else if (self.textAlignment == NSTextAlignmentRight) {
//        rect.origin.x = bounds.size.width - size.width;
//    }
//    rect.size.width = size.width;
    [[self placeholder] drawInRect:self.bounds withAttributes:attr];
    
    
}

//控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    CGSize size = [[NSString string] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil]];
    CGRect inset = CGRectMake(bounds.origin.x,
                              1.0f,
                              bounds.size.width,
                              size.height);//更好理解些
    return inset;
}

- (BOOL) resignFirstResponder {
    [super resignFirstResponder];
    
    return YES;
}


- (UIView*) generateToolbar {
    UIView* toolbar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    toolbar.backgroundColor = [UIColor whiteColor];
    
    UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, toolbar.bounds.size.width, 0.5)];
    topLine.backgroundColor = [UIColor lightGrayColor];
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [toolbar addSubview:topLine];
    
    UIButton *finishedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [finishedButton setTitle:@"完成" forState:UIControlStateNormal];
    finishedButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [finishedButton addTarget:self action:@selector(doneButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    finishedButton.frame = CGRectMake(toolbar.frame.size.width - 64 - 10, 0, 64, 44);
    finishedButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    [toolbar addSubview:finishedButton];
    [topLine bringSubviewToFront:topLine];
    return toolbar;
}

- (void) doneButtonDidPressed:(id)sender {
    if (self.doneDelegate && [self.doneDelegate respondsToSelector:@selector(doneButtonDidPressedDelegate:)]) {
        [self.doneDelegate doneButtonDidPressedDelegate:sender];
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
        UIEdgeInsets contentInsets           = tableView.contentInset;
        contentInsets.bottom                 = keyboardSize.height - tableViewGap;
        //        contentInsets.top                    = 70.0f;
        
        // Prepare for the animation
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
        
        // Make sure first responder is visible
        //        [tableView scrollFirstResponderIntoView];
        
        //        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        //        UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
        //        CGRect frame = firstResponder.frame;
        //        subView = firstResponder.superview.superview.superview;
        //        [tableView setContentOffset:CGPointMake(0.0f, subView.frame.origin.y - 10.0f) animated:YES];
        
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
        
        UIEdgeInsets contentInsets           = tableView.contentInset;
        //        contentInsets.top                    = 70.0f;
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
                             //                             tableView.contentOffset         = CGPointMake(0.0f, -70.0f);
                         }
         
                         completion:nil];
        
    }
}


@end
