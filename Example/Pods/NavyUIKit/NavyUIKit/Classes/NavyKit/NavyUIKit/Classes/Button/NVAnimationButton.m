//
//  NVAnimationButton.m
//  Navy
//
//  Created by Jelly on 8/20/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVAnimationButton.h"
#import "NVLabel.h"
#import "Macros.h"
#import <GLKit/GLKit.h>




@implementation NVAnimationElement

@end




typedef NS_ENUM(NSUInteger, NVAnimationViewType) {
    NVAnimationViewTypeNormal,
    NVAnimationViewTypeWithCircleProgress,
    NVAnimationViewTypeWithComplete,
    NVAnimationViewTypeWithFailure,
};



static CGFloat const KVNInfiniteLoopAnimationDuration = 1.0f;



@interface NVAnimationView : UIView
@property (nonatomic, strong) NVLabel* uiTitle;
@property (nonatomic, strong) CAShapeLayer* layerAnimation;
@property (nonatomic, assign) NVAnimationViewType type;
@property (nonatomic, assign) CGFloat circleSize;
- (id) initWithFrame:(CGRect)frame withType:(NVAnimationViewType)type;
- (void) setButtonTitle:(NSString*)buttonTitle;
- (CAShapeLayer*) makeCircleProgressLayer;
- (CAShapeLayer*) makeCompleteLayer;
- (CAShapeLayer*) makeFailureLayer;
- (void) animateCircleWithInfiniteLoop;
- (void) animateComplete;
- (void) animateFailure;
@end


@implementation NVAnimationView

- (id) initWithFrame:(CGRect)frame withType:(NVAnimationViewType)type {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor        = [UIColor clearColor];
        
        [self addSubview:self.uiTitle];
        [self.layer addSublayer:self.layerAnimation];
        
        self.userInteractionEnabled = NO;
        self.type = type;
    }
    
    return self;
}

- (CGFloat) circleSize {
    CGFloat appearanceCircleSize = [[[self class] appearance] circleSize];
    
    if (appearanceCircleSize != 0) {
        _circleSize = appearanceCircleSize;
    }
    
    if (_circleSize == 0) {
        _circleSize = self.frame.size.height/2.0f;
    }
    
    return _circleSize;
}

- (NVLabel*) uiTitle {
    if (_uiTitle == nil) {
        
        _uiTitle                = [[NVLabel alloc] init];
        _uiTitle.font           = nvNormalFontWithSize(18.0f + fontScale);
        _uiTitle.textAlignment  = NSTextAlignmentCenter;
        _uiTitle.textColor      = COLOR_DEFAULT_WHITE;
        _uiTitle.text           = @"";
    }
    
    return _uiTitle;
}

- (CAShapeLayer*) layerAnimation {
    if (_layerAnimation == nil) {
        _layerAnimation = [CAShapeLayer layer];

    }
    
    return _layerAnimation;
}

- (CAShapeLayer*) makeCircleProgressLayer {
    CGFloat radius = (self.circleSize / 2.0f);
    CGPoint center = CGPointMake(radius, radius);
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:GLKMathDegreesToRadians(-45.0f)
                                                            endAngle:GLKMathDegreesToRadians(275.0f)
                                                           clockwise:YES];
    
    _layerAnimation.path = circlePath.CGPath;
    _layerAnimation.strokeColor = COLOR_DEFAULT_WHITE.CGColor;
    _layerAnimation.fillColor = [UIColor clearColor].CGColor;
    _layerAnimation.lineWidth = 1.0f;
    
    CGSize size = self.frame.size;
    _layerAnimation.frame      = CGRectMake(size.width/3 - self.circleSize,
                                            (size.height - self.circleSize)/2,
                                            self.circleSize,
                                            self.circleSize);
    
    return _layerAnimation;
}

- (CAShapeLayer*) makeCompleteLayer {
    
    CGSize size = self.frame.size;
    CGFloat radius = (self.circleSize / 2.0f);
    CGPoint center = CGPointMake(radius, radius);
    
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:GLKMathDegreesToRadians(0.0f)
                                                            endAngle:GLKMathDegreesToRadians(360.0f)
                                                           clockwise:YES];

    [circlePath moveToPoint:CGPointMake(0.0f, self.circleSize/2)];
    [circlePath addLineToPoint:CGPointMake(self.circleSize/8*3, self.circleSize/4*3)];
    [circlePath addLineToPoint:CGPointMake(self.circleSize/8*7, self.circleSize/8)];
    
    
    _layerAnimation.path = circlePath.CGPath;
    _layerAnimation.strokeColor = COLOR_DEFAULT_WHITE.CGColor;
    _layerAnimation.fillColor = [UIColor clearColor].CGColor;
    _layerAnimation.lineWidth = 1.0f;
    
    _layerAnimation.frame      = CGRectMake(size.width/3 - self.circleSize,
                                            (size.height - self.circleSize)/2,
                                            self.circleSize,
                                            self.circleSize);
    
    return _layerAnimation;
}

- (CAShapeLayer*) makeFailureLayer {
    
    CGSize size = self.frame.size;
    CGFloat radius = (self.circleSize / 2.0f);
    CGPoint center = CGPointMake(radius, radius);
    
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:GLKMathDegreesToRadians(0.0f)
                                                            endAngle:GLKMathDegreesToRadians(360.0f)
                                                           clockwise:YES];
    
    [circlePath moveToPoint:CGPointMake(self.circleSize/4, self.circleSize/4)];
    [circlePath addLineToPoint:CGPointMake(self.circleSize/4*3, self.circleSize/4*3)];
    [circlePath moveToPoint:CGPointMake(self.circleSize/4*3, self.circleSize/4)];
    [circlePath addLineToPoint:CGPointMake(self.circleSize/4, self.circleSize/4*3)];
    
    _layerAnimation.path = circlePath.CGPath;
    _layerAnimation.strokeColor = COLOR_DEFAULT_WHITE.CGColor;
    _layerAnimation.fillColor = [UIColor clearColor].CGColor;
    _layerAnimation.lineWidth = 1.0f;
    
    _layerAnimation.frame      = CGRectMake(size.width/3 - self.circleSize,
                                            (size.height - self.circleSize)/2,
                                            self.circleSize,
                                            self.circleSize);
    
    return _layerAnimation;
}

- (void) setType:(NVAnimationViewType)type {
    _type = type;
    
    CGSize size = self.frame.size;
    
    switch (_type) {
        case NVAnimationViewTypeNormal:
            self.layerAnimation.hidden = YES;
            self.uiTitle.hidden = NO;
            
            
            self.uiTitle.frame      = CGRectMake(0.0f, 0.0f, size.width, size.height);
            
            break;

        case NVAnimationViewTypeWithCircleProgress:
        case NVAnimationViewTypeWithComplete:
        case NVAnimationViewTypeWithFailure:
            self.layerAnimation.hidden = NO;
            self.uiTitle.hidden = NO;

            self.uiTitle.frame          = CGRectMake(size.width/3, 0.0f, size.width/5*2, size.height);
            self.layerAnimation.frame   = CGRectMake(size.width/3 - self.circleSize,
                                                     (size.height - self.circleSize)/2,
                                                     self.circleSize,
                                                     self.circleSize);
            
            if (self.type == NVAnimationViewTypeWithCircleProgress) {
                [self makeCircleProgressLayer];
                [self animateCircleWithInfiniteLoop];
            } else if (self.type == NVAnimationViewTypeWithComplete) {
                [self makeCompleteLayer];
            } else if (self.type == NVAnimationViewTypeWithFailure) {
                [self makeFailureLayer];
            }
            
            break;
            
        default:
            break;
    }
}

- (void) setButtonTitle:(NSString *)buttonTitle {
    self.uiTitle.text       = buttonTitle;
}

- (void) animateCircleWithInfiniteLoop {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0f * KVNInfiniteLoopAnimationDuration);
    rotationAnimation.duration = KVNInfiniteLoopAnimationDuration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.layerAnimation addAnimation:rotationAnimation
                               forKey:@"rotationAnimation"];
}

- (void) animateComplete {
    [self.layerAnimation removeAllAnimations];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = KVNInfiniteLoopAnimationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    [self.layerAnimation addAnimation:animation forKey:@"strokeEnd"];
}

- (void) animateFailure {
    [self.layerAnimation removeAllAnimations];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = KVNInfiniteLoopAnimationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    [self.layerAnimation addAnimation:animation forKey:@"strokeEnd"];
}

@end






@interface NVAnimationButton ()
@property (nonatomic, strong) NVAnimationView* uiNormalView;
@property (nonatomic, strong) NVAnimationView* uiLoadingView;
@property (nonatomic, strong) NVAnimationView* uiResultView;
@property (nonatomic, strong) NVAnimationElement* elementComplete;
@property (nonatomic, strong) NVAnimationElement* elementFailure;
@property (nonatomic, assign) CGFloat circleSize;
@property (nonatomic, assign) CGFloat loadingDelay;
@end



@implementation NVAnimationButton


- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.uiNormalView           = [[NVAnimationView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                        0.0f,
                                                                                        frame.size.width,
                                                                                        frame.size.height)
                                                                    withType:NVAnimationViewTypeNormal];
        [self addSubview:self.uiNormalView];
        
        
        self.uiLoadingView          = [[NVAnimationView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                        frame.size.height,
                                                                                        frame.size.width,
                                                                                        frame.size.height)
                                                                    withType:NVAnimationViewTypeWithCircleProgress];
        [self addSubview:self.uiLoadingView];
        
        
        self.uiResultView           = [[NVAnimationView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                        frame.size.height,
                                                                                        frame.size.width,
                                                                                        frame.size.height)
                                                                    withType:NVAnimationViewTypeWithComplete];
        [self addSubview:self.uiResultView];
    }
    
    return self;
}



- (CGFloat) circleSize {
    CGFloat appearanceCircleSize = [[[self class] appearance] circleSize];
    
    if (appearanceCircleSize != 0) {
        _circleSize = appearanceCircleSize;
    }
    
    if (_circleSize == 0) {
        _circleSize = self.frame.size.height/2.0f;
    }
    
    return _circleSize;
}


- (void) setTitle:(NSString *)title forState:(UIControlState)state {
    
}


- (void) setNormal:(NVAnimationElement *(^)())normalElement
           loading:(NVAnimationElement *(^)())loadingElement
          complete:(NVAnimationElement *(^)())completeElement
           failure:(NVAnimationElement *(^)())failureElement {
    
    if (normalElement) {
        NVAnimationElement* element = normalElement();
        if (element) {
            [self.uiNormalView setButtonTitle:element.buttonTitle];
        }
    }
    
    if (loadingElement) {
        NVAnimationElement* element = loadingElement();
        if (element) {
            [self.uiLoadingView setButtonTitle:element.buttonTitle];
            
            self.loadingDelay = element.delay;
        }
    }
    
    if (completeElement) {
        NVAnimationElement* element = completeElement();
        if (element) {
            self.elementComplete = element;
            [self.uiResultView setButtonTitle:element.buttonTitle];
        }
    }
    
    if (failureElement) {
        NVAnimationElement* element = failureElement();
        if (element) {
            self.elementFailure = element;
            [self.uiResultView setButtonTitle:element.buttonTitle];
        }
    }
}


- (void) startLoadingAnimation {
    
    CGSize size = self.frame.size;
    
    CGRect frame   = CGRectMake(0.0f, 0.0f, size.width, size.height);
    self.uiNormalView.frame = frame;
    
    frame          = CGRectMake(0.0f, size.height, size.width, size.height);
    self.uiLoadingView.frame = frame;
    
    UIColor* disableColor = self.disableColor;
    self.disableColor = self.normalColor;
    self.enabled = NO;
    self.disableColor = disableColor;
    
    [UIView animateWithDuration:0.35f
                     animations:^{
                         CGRect frame   = CGRectMake(0.0f, 0.0f, size.width, size.height);
                         self.uiLoadingView.frame = frame;
                         
                         frame          = CGRectMake(0.0f, -size.height, size.width, size.height);
                         self.uiNormalView.frame = frame;
                     }
                     completion:^(BOOL finished) {
        
                         if (self.loadingDelay > 0.0f) {
                             [self performSelector:@selector(startCompleteAnimation)
                                        withObject:nil
                                        afterDelay:self.loadingDelay];
                         }
                     }];

}

- (void) startCompleteAnimation {
    CGSize size = self.frame.size;
    
    CGRect frame   = CGRectMake(0.0f, 0.0f, size.width, size.height);
    self.uiLoadingView.frame = frame;
    
    frame          = CGRectMake(0.0f, size.height, size.width, size.height);
    self.uiResultView.frame = frame;
    
    
    UIColor* disableColor = self.disableColor;
    self.disableColor = self.normalColor;
    self.enabled = NO;
    self.disableColor = disableColor;
    
    [UIView animateWithDuration:0.35f
                     animations:^{
                         CGRect frame   = CGRectMake(0.0f, 0.0f, size.width, size.height);
                         self.uiResultView.frame = frame;
                         
                         frame          = CGRectMake(0.0f, -size.height, size.width, size.height);
                         self.uiLoadingView.frame = frame;
                     }
                     completion:^(BOOL finished) {
    
                     }];
    
    self.uiResultView.type = NVAnimationViewTypeWithComplete;
    [self.uiResultView setButtonTitle:self.elementComplete.buttonTitle];
    [self.uiResultView animateComplete];
}

- (void) startFailureAnimation {
    CGSize size = self.frame.size;
    
    CGRect frame   = CGRectMake(0.0f, 0.0f, size.width, size.height);
    self.uiLoadingView.frame = frame;
    
    frame          = CGRectMake(0.0f, size.height, size.width, size.height);
    self.uiResultView.frame = frame;
    

    UIColor* disableColor = self.disableColor;
    self.disableColor = self.normalColor;
    self.enabled = NO;
    self.disableColor = disableColor;
    
    [UIView animateWithDuration:0.35f
                     animations:^{
                         CGRect frame   = CGRectMake(0.0f, 0.0f, size.width, size.height);
                         self.uiResultView.frame = frame;
                         
                         frame          = CGRectMake(0.0f, -size.height, size.width, size.height);
                         self.uiLoadingView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    self.uiResultView.type = NVAnimationViewTypeWithFailure;
    [self.uiResultView setButtonTitle:self.elementFailure.buttonTitle];
    [self.uiResultView animateFailure];
}


- (void) restore {
    CGSize size = self.frame.size;
    
    CGRect frame    = CGRectMake(0.0f, 0.0f, size.width, size.height);
    self.uiResultView.frame = frame;
    
    frame           = CGRectMake(0.0f, size.height, size.width, size.height);
    self.uiNormalView.frame = frame;
    
    
    self.enabled = YES;
    [UIView animateWithDuration:0.35f
                     animations:^{
                         CGRect frame   = CGRectMake(0.0f, 0.0f, size.width, size.height);
                         self.uiNormalView.frame = frame;
                         
                         frame          = CGRectMake(0.0f, -size.height, size.width, size.height);
                         self.uiResultView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     
                     }];
}


@end


