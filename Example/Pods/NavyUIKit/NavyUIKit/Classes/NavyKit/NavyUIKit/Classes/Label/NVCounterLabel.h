//
//  NVCounterLabel.h
//  Navy
//
//  Created by Jelly on 7/29/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NVCounterLabel : UILabel
@property (nonatomic, assign) double fontSize;
- (void) countNumberWithDuration:(CGFloat)duration
                      fromNumber:(double)startNumber
                        toNumber:(double)endNumber;
@end
