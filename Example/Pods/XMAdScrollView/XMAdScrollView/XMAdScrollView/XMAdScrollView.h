//
//  XMAdScrollView.h
//  XMAdScrollView
//
//  Created by 宋乃银 on 16/11/1.
//  Copyright © 2016年 camhow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XMPageControlAlignment) {
    
    XMPageControlAlignmentLeft = -1,
    XMPageControlAlignmentCenter = 0,
    XMPageControlAlignmentRight
};


@protocol XMAdScrollViewDelegate;
@protocol XMAdScrollViewItemModelDelegate;


@interface XMAdScrollView : UIView
/**
 设置delegate,监听点击事件
 */
@property(nonatomic,weak)id<XMAdScrollViewDelegate>delegate;
/**
 设置数据数组 会自动刷新XMAdScrollView，注意数组里的对象需要实现XMAdScrollViewItemModelDelegate协议
 */
@property(nonatomic,strong)NSArray<id<XMAdScrollViewItemModelDelegate>> * itemDataArray;

/**
 UIPageControl的对齐方式，默认XMPageControlAlignmentRight
 */
@property(nonatomic,assign)XMPageControlAlignment pageControlAligment;

@property(nonatomic,strong)UIColor * currentPageIndicatorTintColor;
@property(nonatomic,strong)UIColor * pageIndicatorTintColor;

/**
 是否显示标题 默认NO
 */
@property(nonatomic,assign)BOOL showTitle;
/**
 时间间隔 默认5s
 */
@property(nonatomic,assign)CGFloat timeInterval;

@end


@protocol XMAdScrollViewItemModelDelegate <NSObject>
@required;
@property(nonatomic,strong)NSString * itemImgURL;
@optional;
@property(nonatomic,strong)NSString * itemTitle;
@end

@protocol XMAdScrollViewDelegate <NSObject>
@optional
-(void)adScrollView:(XMAdScrollView *)scrollView didSelectedAtIndex:(NSInteger)index;

@end
