//
//  VSIBBroswerView.h
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//
/*
 用法：
 1.展示多张图片
     [self.broswer removeFromSuperview];
     self.broswer = [[VSIBBroswerView alloc] initWithImageArray:self.dataSource currentIndex:indexPath.row];
     [self.broswer showInCell:cell];
 2.加上导航
     [self.broswer removeFromSuperview];
     self.broswer = [[VSIBBroswerView alloc] initWithImageArray:self.dataSource currentIndex:indexPath.row];
     [self.broswer showInCell:cell];
     self.broswer.showNavigationBar = YES;
     [self.broswer setRightItemTouchedBlock:^(NSInteger index, NSString* imageURL, UIImage* image) {
     
     }];
 
 */

#import <UIKit/UIKit.h>
#import <DJMacros/DJMacro.h>

typedef void(^VSIBRightItemTouchBlock)(NSInteger currentIndex, NSString* imageURL, UIImage* image);

@interface VSIBBroswerView : UIView

@property (nonatomic, assign) BOOL      titleLabelHidden;
@property (nonatomic, assign) BOOL      showNavigationBar;
@property (nonatomic, assign) BOOL      tapHidden;
@property (nonatomic, assign) BOOL      rightButtonHidden;
@property (nonatomic, strong) UIColor*  navigationBarBackgroundColor;
@property (nonatomic, strong) UIColor*  navigationBarTintColor;

PP_COPY_BLOCK(VSIBRightItemTouchBlock, rightItemTouchedBlock);

/**
 * @brief 初始化方法  图片以数组的形式传入, 需要显示的当前图片的索引
 *
 * @param  imageArray 需要显示的图片以数组的形式传入
 * @param  index 需要显示的当前图片的索引
 */
- (instancetype)initWithImageArray:(NSArray<UIImage *> *)imageArray
                      currentIndex:(NSInteger)index;

- (instancetype)initWithImageURLs:(NSArray<NSString *> *)imageURLs
                 palceHolderImage:(UIImage *) placeHolderImage
                     currentIndex:(NSInteger)index;

- (void)showFromView:(UIView *) fromView;

- (void)dismiss;

@end
