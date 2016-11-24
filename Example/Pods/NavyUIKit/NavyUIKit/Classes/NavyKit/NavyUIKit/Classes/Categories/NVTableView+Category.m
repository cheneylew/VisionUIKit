//
//  NVTableView+Category.m
//  Navy
//
//  Created by Jelly on 7/8/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableView+Category.h"

@implementation NVTableView (Category)

@end



@implementation NVTableView (ReloadCell)

- (void) reloadCell:(NVTableViewCell *)cell {
    NSIndexPath* indexPath = [self indexPathForCell:cell];
    if (indexPath != nil) {
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

@end
