//
//  NVCounterLabel.m
//  Navy
//
//  Created by Jelly on 7/29/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVCounterLabel.h"
#import "Macros.h"


typedef struct {
    CGFloat x;
    CGFloat y;
} Point2D;

@interface FYBezierCurve : NSObject

Point2D PointOnCubicBezier(Point2D* cp, CGFloat t);

@end


@implementation FYBezierCurve

Point2D PointOnCubicBezier( Point2D* cp, CGFloat t ) {
    //    x = (1-t)^3 *x0 + 3*t*(1-t)^2 *x1 + 3*t^2*(1-t) *x2 + t^3 *x3
    //    y = (1-t)^3 *y0 + 3*t*(1-t)^2 *y1 + 3*t^2*(1-t) *y2 + t^3 *y3
    CGFloat   ax, bx, cx;
    CGFloat   ay, by, cy;
    CGFloat   tSquared, tCubed;
    Point2D result;
    
    /*計算多項式係數*/
    
    cx = 3.0 * (cp[1].x - cp[0].x);
    bx = 3.0 * (cp[2].x - cp[1].x) - cx;
    ax = cp[3].x - cp[0].x - cx - bx;
    
    cy = 3.0 * (cp[1].y - cp[0].y);
    by = 3.0 * (cp[2].y - cp[1].y) - cy;
    ay = cp[3].y - cp[0].y - cy - by;
    
    /*計算位於參數值t的曲線點*/
    
    tSquared = t * t;
    tCubed = tSquared * t;
    
    result.x = (ax * tCubed) + (bx * tSquared) + (cx * t) + cp[0].x;
    result.y = (ay * tCubed) + (by * tSquared) + (cy * t) + cp[0].y;
    
    return result;
}

@end



#define kPointsNumber 100 // 即数字跳100次
#define kDurationTime 5.0 // 动画时间
#define kStartNumber  0   // 起始数字
#define kEndNumber    1000// 结束数字

@interface NVCounterLabel ()
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) double startNumber;
@property (nonatomic, assign) double endNumber;
@property (nonatomic, assign) NSInteger indexNumber;
@property (nonatomic, assign) CGFloat lastTime;
@property (nonatomic, assign) Point2D startPoint;
@property (nonatomic, assign) Point2D endPoint;
@property (nonatomic, assign) Point2D controlPoint1;
@property (nonatomic, assign) Point2D controlPoint2;
@property (nonatomic, strong) NSMutableArray* numberPoints;

- (void) setText:(id)text attributesBlock:(NSMutableAttributedString *(^)(NSMutableAttributedString *mutableAttributedString))block;
- (void) clearUpValue;
- (void) initPoints;
- (void) changeNumberBySelector;
- (void) updateDisplay:(double)number;
@end



@implementation NVCounterLabel

- (void) countNumberWithDuration:(CGFloat)duration
                      fromNumber:(double)startNumber
                        toNumber:(double)endNumber {
    
    self.duration = duration;
    self.startNumber = startNumber;
    self.endNumber = endNumber;
    
    [self clearUpValue];
    [self initPoints];
    [self changeNumberBySelector];
    
}

- (void) clearUpValue {
    self.lastTime = 0;
    self.indexNumber = 0;
    
    [self updateDisplay:self.startNumber];
}

- (void) initPoints {
    [self initBezierPoints];
    
    Point2D bezierCurvePoints[4] = {_startPoint, _controlPoint1, _controlPoint2, _endPoint};
    _numberPoints = [[NSMutableArray alloc] init];
    CGFloat dt;
    dt = 1.0 / (kPointsNumber - 1);
    for (NSInteger i = 0; i < kPointsNumber; i++) {
        Point2D point = PointOnCubicBezier(bezierCurvePoints, i*dt);
        CGFloat durationTime = point.x * _duration;
        CGFloat value = point.y * (_endNumber - _startNumber) + _startNumber;
        [self.numberPoints addObject:[NSArray arrayWithObjects:
                                      [NSNumber numberWithFloat:durationTime],
                                      [NSNumber numberWithFloat:value],
                                      nil]];
    }
}

- (void) initBezierPoints {
    // 可到http://cubic-bezier.com自定义贝塞尔曲线
    
    _startPoint.x = 0.0f;
    _startPoint.y = 0.0f;
    
    _controlPoint1.x = 0.25f;
    _controlPoint1.y = 0.1f;
    
    _controlPoint2.x = 0.25f;
    _controlPoint2.y = 1.0f;
    
    _endPoint.x = 1.0f;
    _endPoint.y = 1.0f;
}

- (void) changeNumberBySelector {
    if (self.indexNumber >= kPointsNumber) {
        [self updateDisplay:_endNumber];
        return;
    } else {
        NSArray *pointValues = [self.numberPoints objectAtIndex:self.indexNumber];
        self.indexNumber++;
        CGFloat value = [(NSNumber *)[pointValues objectAtIndex:1] intValue];
        CGFloat currentTime = [(NSNumber *)[pointValues objectAtIndex:0] floatValue];
        CGFloat timeDuration = currentTime - self.lastTime;
        self.lastTime = currentTime;
        
        [self updateDisplay:value];
        [self performSelector:@selector(changeNumberBySelector) withObject:nil afterDelay:timeDuration];
    }
}

- (void) setText:(id)text
 attributesBlock:(NSMutableAttributedString *(^)(NSMutableAttributedString *))block {
    
    if (self.fontSize == 0) {
        self.fontSize = 14.0f + fontScale;
    }
    
    NSMutableAttributedString* attributeString = nil;
    if ([text isKindOfClass:[NSString class]]) {
        attributeString         = [[NSMutableAttributedString alloc] initWithString:text
                                                                         attributes:ATTR_DICTIONARY3(COLOR_DEFAULT_WHITE, nvNumberFontWithSize(self.fontSize))];
    } else if ([text isKindOfClass:[NSAttributedString class]]) {
        attributeString         = [[NSMutableAttributedString alloc] initWithAttributedString:text];
    }
    
    if (block) {
        attributeString = block(attributeString);
    }
    
    [self setNeedsDisplay];
    [self invalidateIntrinsicContentSize];
    
    [super setAttributedText:attributeString];
}

- (void) updateDisplay:(double)number {
    
    NSString* value = [NSString stringWithFormat:@"%.02f", number];
    [self setText:value
  attributesBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
      return mutableAttributedString;
  }];
    
    [self setNeedsDisplay];
}


@end
