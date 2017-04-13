//
//  VSIBBroswerView.m
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//
#define Screen_BOUNDS   [UIScreen mainScreen].bounds
#define Screen_W        [UIScreen mainScreen].bounds.size.width
#define Screen_H        [UIScreen mainScreen].bounds.size.height
#define SpaceWidth      10 // 图片距离左右间距

#import "VSIBBroswerView.h"
#import "VSIBImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+Bundle.h"
#import <KKCategories/KKCategories.h>
#import <DJMacros/DJMacro.h>

@interface VSIBBroswerView ()<VSIBImageViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<UIImage *> *imageArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, assign) BOOL useImageURL;
@property (nonatomic, strong) NSArray<NSString *> *imageURLs;
@property (nonatomic, strong) UIImage *placeHolderImage;

@property (nonatomic, strong) UIView *customNavigationBar;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation VSIBBroswerView

- (instancetype)initWithImageArray:(NSArray<UIImage *> *)imageArray currentIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.imageArray = imageArray;
        self.count = self.imageArray.count;
        self.index = index;
        self.useImageURL = NO;
        self.tapHidden = YES;
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithImageURLs:(NSArray<NSString *> *)imageURLs
                 palceHolderImage:(UIImage *) placeHolderImage
                     currentIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        self.imageURLs = imageURLs;
        self.count = self.imageURLs.count;
        self.placeHolderImage = placeHolderImage;
        self.useImageURL = YES;
        self.index = index;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    int index = 0;
    if (self.useImageURL) {
        for (NSString *imageURL in self.imageURLs) {
            VSIBImageView *imageView = [[VSIBImageView alloc] init];
            imageView.delegate = self;
            imageView.tag = index;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:self.placeHolderImage];
            [self.scrollView addSubview:imageView];
            index ++;
        }
    } else {
        for (UIImage *image in self.imageArray) {
            VSIBImageView *imageView = [[VSIBImageView alloc] init];
            imageView.delegate = self;
            imageView.image = image;
            imageView.tag = index;
            [self.scrollView addSubview:imageView];
            index ++;
        }
    }
}

#pragma mark - Public propertys

- (void)setTitleLabelHidden:(BOOL)titleLabelHidden {
    _titleLabelHidden = titleLabelHidden;
    self.numberLabel.hidden = _titleLabelHidden;
}

- (void)setShowNavigationBar:(BOOL)showNavigationBar {
    _showNavigationBar = showNavigationBar;
    self.customNavigationBar.hidden = !showNavigationBar;
}

- (void)setTapHidden:(BOOL)tapHidden {
    _tapHidden = tapHidden;
    
}

- (void)setRightButtonHidden:(BOOL)rightButtonHidden {
    _rightButtonHidden = rightButtonHidden;
    self.rightButton.hidden = rightButtonHidden;
}

- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor {
    _navigationBarTintColor = navigationBarTintColor;
    [self.customNavigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setTitleColor:navigationBarTintColor forState:UIControlStateNormal];
        }
    }];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor {
    if (!_navigationBarBackgroundColor) {
        self.customNavigationBar.backgroundColor = navigationBarBackgroundColor;
    };
    _navigationBarBackgroundColor = navigationBarBackgroundColor;
}

#pragma mark - Getter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:Screen_BOUNDS];
        _scrollView.backgroundColor = HEX(0xffffff);
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake((Screen_W + 2*SpaceWidth) * self.count, Screen_H);
        _scrollView.contentOffset = CGPointMake(Screen_W * self.index, 0);
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        [self numberLabel];
    }
    return _scrollView;
}

- (UILabel *)numberLabel
{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, Screen_W, 40)];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)self.index+1, (long)self.count];
        [self addSubview:_numberLabel];
    }
    return _numberLabel;
}

- (UIView *)customNavigationBar {
    if (!_customNavigationBar) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FIT6(128))];
        view.backgroundColor = HEX(0x082d55);
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [backButton setImage:[UIImage vs_imageName:@"vs_navigation_back_normal"] forState:UIControlStateNormal];
        backButton.frame = CGRectMake(FIT6(10), FIT6(14)+FIT6(40), FIT6(77), FIT6(56));
        [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        backButton.tintColor = [UIColor whiteColor];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [view addSubview:backButton];
        
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightButton setTitle:@"删除" forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(0, FIT6(14)+FIT6(40), FIT6(77), FIT6(56));
        rightButton.right = view.width - FIT6(28);
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        WEAK_SELF;
        [rightButton jk_addActionHandler:^(NSInteger tag) {
            BLOCK_SAFE_RUN(weakself.rightItemTouchedBlock,
                           weakself.index,
                           (NSString *)(weakself.imageURLs.count?weakself.imageURLs[weakself.index]:nil),
                           (UIImage *)(weakself.imageArray.count?weakself.imageArray[weakself.index]:nil));
        }];
        self.rightButton = rightButton;
        self.rightButton.hidden = self.rightButtonHidden;
        [view addSubview:rightButton];
        
        [self insertSubview:view belowSubview:self.numberLabel];
        _customNavigationBar = view;
        
        self.numberLabel.top = FIT6(34);
    }
    return _customNavigationBar;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / Screen_W;
    self.index = index;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:@"VSIBImageView"]) {
            VSIBImageView *imageView = (VSIBImageView *)obj;
            [imageView resetView];
        }
    }];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)self.index+1, (long)self.count];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 主要为了设置每个图片的间距，并且使图片铺满整个屏幕，实际上就是scrollview每一页的宽度是屏幕宽度+2*Space居中，图片左边从每一页的Space开始，达到间距且居中效果
    _scrollView.bounds = CGRectMake(0, 0, Screen_W + 2 * SpaceWidth, Screen_H);
    _scrollView.center = self.center;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(SpaceWidth + (Screen_W+20) * idx, 0, Screen_W, Screen_H);
    }];
    
    NSInteger idx = 0;
    if (self.index <= self.count) {
        idx = self.index;
    } else {
        idx = self.count-1;
    }
    [self.scrollView setContentOffset:CGPointMake(SpaceWidth + (Screen_W+20) * idx - 10, 0)];
}

- (void)showFromView:(UIView *) fromView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, Screen_W, Screen_H);
    self.center = fromView.center;
    if (fromView == nil) {
        self.center = window.center;
    }
    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.center = window.center;
        [window.rootViewController.view addSubview:self];
    }];
}

#pragma mark - VSIBImageViewDelegate
- (void)stImageViewSingleClick:(VSIBImageView *)imageView
{
    if (self.tapHidden) {
        [self dismiss];
    }
}

- (void)dismiss
{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end















