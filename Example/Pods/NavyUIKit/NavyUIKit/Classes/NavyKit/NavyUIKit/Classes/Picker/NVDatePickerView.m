//
//  NVDatePickerView.m
//  Navy
//
//  Created by Steven.Lin on 25/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVDatePickerView.h"
#import "NVBackgroundControl.h"
#import "Macros.h"
#import "NSString+Category.h"


@interface NVDatePickerView ()
<UIPickerViewDataSource,
UIPickerViewDelegate,
NVBackgroundControlDelegate>
@property (nonatomic, strong) UIView* uiToolbar;
@property (nonatomic, strong) UIDatePicker* uiPickerView;
- (void) onCancel:(id)sender;
- (void) onDone:(id)sender;
@end


#define HEIGHT_OF_TOOLBAR           (44.0f)
#define HEIGHT_OF_PICKER_VIEW       (214.0f)


@implementation NVDatePickerView

- (id) init {
    CGRect frame        = CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH, HEIGHT_OF_PICKER_VIEW + HEIGHT_OF_TOOLBAR);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    = COLOR_DEFAULT_WHITE;
        
        self.uiToolbar          = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                           0.0f,
                                                                           APPLICATIONWIDTH,
                                                                           HEIGHT_OF_TOOLBAR)];
        [self addSubview:self.uiToolbar];
        
        UIButton* button        = [[UIButton alloc] initWithFrame:CGRectMake(15.0f,
                                                                             (HEIGHT_OF_TOOLBAR - 20.0f)/2,
                                                                             60.0f,
                                                                             20.0f)];
        [self.uiToolbar addSubview:button];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:COLOR_DEFAULT_WHITE forState:UIControlStateNormal];
        button.titleLabel.font  = nvNormalFontWithSize(18.0f);
        [button addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        
        
        button        = [[UIButton alloc] initWithFrame:CGRectMake(APPLICATIONWIDTH - 15.0f - 60.0f,
                                                                   (HEIGHT_OF_TOOLBAR - 20.0f)/2,
                                                                   60.0f,
                                                                   20.0f)];
        [self.uiToolbar addSubview:button];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:COLOR_DEFAULT_WHITE forState:UIControlStateNormal];
        button.titleLabel.font  = nvNormalFontWithSize(18.0f);
        [button addTarget:self action:@selector(onDone:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        self.uiPickerView           = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f,
                                                                                     HEIGHT_OF_TOOLBAR,
                                                                                     APPLICATIONWIDTH,
                                                                                     HEIGHT_OF_PICKER_VIEW)];
        [self addSubview:self.uiPickerView];
        self.uiPickerView.datePickerMode = UIDatePickerModeDate;
        
    }
    
    return self;
}


- (void) show {
    UIWindow* window        = [UIApplication sharedApplication].delegate.window;
    [self showInView:window];
}

- (void) showInView:(UIView *)view {
    CGRect bounds = view.bounds;
    NVBackgroundControl* bgControl  = [[NVBackgroundControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                                            0.0f,
                                                                                            bounds.size.width,
                                                                                            bounds.size.height)];
    [view addSubview:bgControl];
    bgControl.delegate      = self;
    [bgControl addSubview:self];
    [bgControl show];
    
    __block CGRect frame    = CGRectMake((bounds.size.width - self.frame.size.width)/2,
                                         bounds.size.height,
                                         self.frame.size.width,
                                         self.frame.size.height);
    self.frame              = frame;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         frame.origin.y = bounds.size.height - self.frame.size.height;
                         self.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}

- (void) hide {
    NVBackgroundControl* bgControl = (NVBackgroundControl*)self.superview;
    if (bgControl) {
        CGRect bounds = bgControl.bounds;
        __block CGRect frame    = CGRectMake((bounds.size.width - self.frame.size.width)/2,
                                             bounds.size.height - self.frame.size.height,
                                             self.frame.size.width,
                                             self.frame.size.height);
        self.frame              = frame;
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             frame.origin.y = bounds.size.height;
                             self.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             [bgControl removeFromSuperview];
                         }];
    }
    
}


- (void) setColorToolbar:(UIColor *)colorToolbar {
    _colorToolbar = colorToolbar;
    
    self.uiToolbar.backgroundColor      = _colorToolbar;
}

- (void) setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    
    self.uiPickerView.minimumDate = minimumDate;
}

- (void) setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    
    self.uiPickerView.maximumDate = maximumDate;
}


- (void) onCancel:(id)sender {
    [self hide];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didDismissAtPickerView:)]) {
        [self.delegate didDismissAtPickerView:self];
    }
}

- (void) onDone:(id)sender {
    [self hide];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(datePickerView:didSelectDateTime:)]) {
        NSString* dateString = [NSString stringFromDate:self.uiPickerView.date];
        [self.delegate datePickerView:self didSelectDateTime:dateString];
    }
}


#pragma mark - NVBackgroundControlDelegate
- (void) didTouchUpInsideOnBackgroundControl:(NVBackgroundControl *)control {
    [self hide];
}


@end


