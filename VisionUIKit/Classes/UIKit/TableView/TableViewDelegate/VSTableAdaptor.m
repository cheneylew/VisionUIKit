//
//  VSTableAdaptor.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTableAdaptor.h"
#import <DJMacros/DJMacro.h>

@implementation VSTableAdaptor

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *value = [self.constructor vs_modelAtIndexPath:indexPath].height;
    return value.floatValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(vs_tableView:didSelectRowAtIndexPath:model:)]) {
        [self.delegate vs_tableView:tableView didSelectRowAtIndexPath:indexPath model:[self.constructor vs_modelAtIndexPath:indexPath]];
    }
}

@end
