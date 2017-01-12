//
//  VSIBCollectionViewCell.m
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//

#define SCREEN_W  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H [[UIScreen mainScreen] bounds].size.height

#import "VSIBCollectionViewCell.h"

@implementation VSIBCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.titleLabel];
}

#pragma mark - getter
- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_W-52)/3, (SCREEN_W-52)/3)];
        _headImageView.backgroundColor = [UIColor blueColor];
        _headImageView.userInteractionEnabled = YES;
    }
    return _headImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (SCREEN_W-52)/3, (SCREEN_W-52)/3, 30)];
        _titleLabel.text = @"10月25  13:24";
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


@end
