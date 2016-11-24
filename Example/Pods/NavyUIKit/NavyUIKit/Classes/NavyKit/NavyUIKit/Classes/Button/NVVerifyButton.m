//
//  NVVerifyButton.m
//  Navy
//
//  Created by Jelly on 7/29/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVVerifyButton.h"


Class object_getClass(id object);


@interface NVVerifyButton () {
    NSTimer* _timerCountDown;
    
}
@property (nonatomic, retain) NSDate* dateCountDown;
@property (nonatomic, retain) Class delegateClass;
- (void) timerCountDown:(NSTimer*)timer;

@end


@implementation NVVerifyButton


- (void) dealloc {
    _delegate = nil;
    [_timerCountDown invalidate];
    _timerCountDown = nil;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:nvNormalFontWithSize(16.0f)];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        
        self.countDown = 60.0f;
    }
    return self;
}

- (void) setDelegate:(id<NVVerifyButtonDelegate>)delegate {
    _delegate = delegate;
    if (_delegate) {
        self.delegateClass = object_getClass(_delegate);
    }else{
        self.delegateClass = nil;
    }
}

- (BOOL)isDelegateValid{
    return (_delegate && object_getClass(_delegate) == _delegateClass);
}

- (void) startCountDown {
    
    self.enabled = NO;
    self.dateCountDown = [NSDate dateWithTimeIntervalSinceNow:_countDown];
    
    if (_timerCountDown == nil) {
        _timerCountDown = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCountDown:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timerCountDown forMode:NSRunLoopCommonModes];
    }
    
    [_timerCountDown fire];
    
    if ([self isDelegateValid] && [self.delegate respondsToSelector:@selector(verifyButton:didChangeState:)]) {
        [self.delegate verifyButton:self didChangeState:NVVerifyButtonStateStartCountDown];
    }
}

- (void) stopCountDown {
    
    self.enabled = YES;
    [_timerCountDown invalidate];
    _timerCountDown = nil;
    [self setTitle:@"重新获取" forState:UIControlStateNormal];
    
    if ([self isDelegateValid]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(verifyButton:didChangeState:)]) {
            [self.delegate verifyButton:self didChangeState:NVVerifyButtonStateStopCountDown];
        }
    }
    
}


- (void) timerCountDown:(NSTimer *)timer {
    
    NSDate* nowDate = [NSDate date];
    NSTimeInterval nowInterval = [nowDate timeIntervalSince1970];
    NSTimeInterval countDownInterval = [self.dateCountDown timeIntervalSince1970];
    
    if (countDownInterval <= nowInterval) {
        [self stopCountDown];
        
    } else {
        self.enabled = NO;
        [self setTitle:[NSString stringWithFormat:@"重发(%.0f秒)", countDownInterval - nowInterval] forState:UIControlStateDisabled];
        
    }
}


@end




