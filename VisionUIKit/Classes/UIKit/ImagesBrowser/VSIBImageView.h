//
//  VSIBImageView.h
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSIBImageViewDelegate;

@interface VSIBImageView : UIImageView

@property (nonatomic, assign) id<VSIBImageViewDelegate>delegate;
@property (nonatomic, strong) UIColor *browserBackgroundColor;

- (void)resetView;

@end

@protocol VSIBImageViewDelegate <NSObject>

- (void)stImageViewSingleClick:(VSIBImageView *)imageView;

@end
