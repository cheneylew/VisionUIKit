//
//  VSPhotoCollectionViewCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/28.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSPhotoCollectionViewCell.h"

@implementation VSPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

@end
