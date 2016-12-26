//
//  NVTableViewNullCell.m
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewNullCell.h"

@implementation NVTableViewNullCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setObject:(id)object {
    [super setObject:object];
    self.item.normalBackgroudColor = self.item.normalBackgroudColor?self.item.normalBackgroudColor:[UIColor clearColor];
    self.backgroundColor = self.item.normalBackgroudColor;
}

@end
