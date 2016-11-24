//
//  NVTableViewCell.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewCell.h"

@implementation NVTableViewCell


#pragma mark - height
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    CGFloat height = 0;
    
    if ([object conformsToProtocol:@protocol(NVTableViewCellItemProtocol)]) {
        if ([object respondsToSelector:@selector(cellHeight)]) {
            if ([object cellHeight]) {
                height = [[object cellHeight] floatValue];
            }
        }
    }
    
    return height;
}

- (void) setObject:(id)object {
    
}


+ (NSString*) cellIdentifier {
    return @"theDefaultCell";
}

+ (CGFloat) heightForCell {
    return 32.0f;
}

@end


