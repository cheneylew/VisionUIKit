//
//  NVTableViewLineCell.m
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"
#import "NVTableViewLineCell.h"

#define CELL_HEIGHT     40.0f

@implementation NVTableViewLineCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        self.clipsToBounds = NO;
        self.contentView.clipsToBounds = NO;
        if ([self.contentView.superview isKindOfClass:[NSClassFromString(@"UITableViewCellScrollView") class]]) {
            self.contentView.superview.clipsToBounds = NO;
        }
        
        self.lineUpper = [NVNoAnimationLayer layer];
        self.lineUpper.frame = CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH, 0.5f);
        self.lineUpper.backgroundColor = COLOR_LINE.CGColor;
        [self.layer addSublayer:self.lineUpper];
        
        self.lineLower = [NVNoAnimationLayer layer];
        self.lineLower.frame = CGRectMake(0.0f, CELL_HEIGHT - 0.5, APPLICATIONWIDTH, 0.5f);
        self.lineLower.backgroundColor = COLOR_LINE.CGColor;
        [self.layer addSublayer:self.lineLower];
        
    }
    return self;
}


#pragma mark - layout
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat line = 0.5f;
    
    self.lineUpper.frame = CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH, line);
    self.lineLower.frame = CGRectMake(0.0f, self.frame.size.height - line, APPLICATIONWIDTH, line);
    
    //    CGRect frame = _lineLower.frame;
    //    frame.origin.y = self.frame.size.height;
    //    _lineLower.frame = frame;
    
    
}

@end



@implementation NVTableViewIndentLineCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        [self.lineUpper setBackgroundColor:COLOR_LINE];
        //        [self.lineLower setBackgroundColor:COLOR_LINE];
        
        CGFloat line = 0.5f;
        
        self.lineUpper.frame = CGRectMake(20.0f, 0.0f, APPLICATIONWIDTH - 20.0f, line);
        self.lineLower.frame = CGRectMake(20.0f, self.frame.size.height, APPLICATIONWIDTH - 20.0f, line);
    }
    
    return self;
}

#pragma mark - layout
//- (void)layoutSubviews{
//    [super layoutSubviews];
//
//
////    [self bringSubviewToFront:self.lineUpper];
////    [self bringSubviewToFront:self.lineLower];
//
//}

+ (NSString*) cellIdentifier {
    return CLS_TABLE_VIEW_INDENT_LINE_CELL;
}

@end




