//
//  NVGradientLayer.m
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVGradientLayer.h"


@implementation NVGradientLayer
@synthesize arrayColors = _arrayColors;


- (void) drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    if ([self.arrayColors count] == 0) {
        return;
    }
    
    CGGradientRef myGradient;
    CGColorSpaceRef myColorSpace;
    size_t locationCount = [self.arrayColors count];
    
    CGFloat* listLocations = malloc(sizeof(CGFloat) * locationCount);
    for (NSInteger i = 0; i < locationCount; i++) {
        CGFloat location = (CGFloat)(i / (CGFloat)(locationCount - 1));
        listLocations[i] = location;
    }
    
    
    CGFloat* listColors = malloc(sizeof(CGFloat) * locationCount * 4);
    for (NSInteger i = 0; i < locationCount; i++) {
        UIColor* color = [self.arrayColors objectAtIndex:i];
        size_t numComponents = CGColorGetNumberOfComponents(color.CGColor);
        if (numComponents == 4) {
            const CGFloat* components = CGColorGetComponents(color.CGColor);
            CGFloat R = components[0];
            CGFloat G = components[1];
            CGFloat B = components[2];
            CGFloat A = components[3];
            
            listColors[i * 4] = R;
            listColors[i * 4 + 1] = G;
            listColors[i * 4 + 2] = B;
            listColors[i * 4 + 3] = A;
        }
    }
    
    
    myColorSpace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorSpace, listColors, listLocations, locationCount);//核心函数就是这个了，要搞清楚一些量化的东西了.
    CGPoint startPoint,endPoint;
    startPoint.x = CGRectGetMaxX(self.bounds) / 2;
    startPoint.y = 0.0f;
    endPoint.x = CGRectGetMaxX(self.bounds) / 2;
    endPoint.y = CGRectGetMaxY(self.bounds);
    CGContextDrawLinearGradient(ctx, myGradient, startPoint, endPoint, 0);//这个是绘制的，你可以通过裁剪来完成特定形状的过度。
    CGColorSpaceRelease(myColorSpace);
    CGGradientRelease(myGradient);
    
    free(listLocations);
    free(listColors);
}


- (NSMutableArray*) arrayColors {
    if (_arrayColors == nil) {
        _arrayColors = [[NSMutableArray alloc] init];
    }
    
    return _arrayColors;
}


- (void) addColor:(UIColor *)color {
    if (color != nil) {
        [self.arrayColors addObject:color];
    }
}

- (void) removeColors {
    [self.arrayColors removeAllObjects];
}

@end

