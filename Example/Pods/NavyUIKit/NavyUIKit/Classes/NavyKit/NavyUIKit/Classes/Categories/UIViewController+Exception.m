//
//  UIViewController+Exception.m
//  Navy
//
//  Created by Jelly on 7/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "UIViewController+Exception.h"
#import "NVLabel.h"
#import "NVButton.h"
#import "NavyUIKit.h"
#import "NSMutableAttributedString+Category.h"


@interface UIViewController (Exception)
- (void) onTryAgain:(id)sender;
- (void) onRestartLoad:(id)sender;
@end


#define TAG_OF_EXCEPTION_VIEW           999001

@implementation UIViewController (Exception)


- (void) showExceptionView {
    [self showExceptionViewInView:self.view];
}


- (void) showExceptionViewInView:(UIView*)view {
    
    UIView* exceptionView = [self exceptionViewInView:view];
    exceptionView.backgroundColor = COLOR_HM_WHITE_GRAY;
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((APPLICATIONWIDTH - 107.0f)/2,
                                                                           (APPLICATIONHEIGHT - 107.0f)/2 - 80.0f,
                                                                           107.0f,
                                                                           107.0f)];
    [exceptionView addSubview:imageView];
    imageView.image     = [UIImage imageNamed:@"icon_exception_server.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NVLabel* label          = [[NVLabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                        APPLICATIONHEIGHT/2,
                                                                        APPLICATIONWIDTH,
                                                                        60.0f)];
    [exceptionView addSubview:label];
    label.font              = nvNormalFontWithSize(16.0f + fontScale);
    label.textColor         = COLOR_HM_GRAY;
    label.textAlignment     = NSTextAlignmentCenter;
    label.numberOfLines     = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor   = [UIColor clearColor];
    
    NSMutableAttributedString* attributedString     = [[NSMutableAttributedString alloc] init];
    [attributedString appendString:@"抱歉, 系统繁忙" withAttributes:ATTR_DICTIONARY(COLOR_HM_BLACK, 18.0f + fontScale)];
    [attributedString addLine:2];
    [attributedString appendString:@"请稍后再试" withAttributes:ATTR_DICTIONARY(COLOR_HM_DARK_GRAY, 14.0f + fontScale)];
    label.attributedText    = attributedString;
    
    
    NVButton* button        = [[NVButton alloc] initWithFrame:CGRectMake((APPLICATIONWIDTH - 100.0f)/2,
                                                                         APPLICATIONHEIGHT/2 + 80.0f,
                                                                         100.0f,
                                                                         30.0f)];
    [exceptionView addSubview:button];
    [button setTitle:@"再试一次" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_HM_BLACK forState:UIControlStateNormal];
    button.titleLabel.font  = nvNormalFontWithSize(14.0f + fontScale);
    button.normalColor      = COLOR_HM_BLACK;
    button.buttonStyle      = NVButtonStyleBorder;
    [button addTarget:self action:@selector(onTryAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:exceptionView];

}



- (void) showErrorView {
    
}


- (void) showOffNetworkView {
    [self showOffNetworkViewInView:self.view];
}

- (void) showOffNetworkViewInView:(UIView *)view {
    
    UIView* exceptionView = [self exceptionViewInView:view];
    
    exceptionView.backgroundColor = COLOR_HM_WHITE_GRAY;
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((APPLICATIONWIDTH - 107.0f)/2,
                                                                           (APPLICATIONHEIGHT - 107.0f)/2 - 80.0f,
                                                                           107.0f,
                                                                           107.0f)];
    [exceptionView addSubview:imageView];
    imageView.image     = [UIImage imageNamed:@"icon_exception_network.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NVLabel* label          = [[NVLabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                        APPLICATIONHEIGHT/2,
                                                                        APPLICATIONWIDTH,
                                                                        60.0f)];
    [exceptionView addSubview:label];
    label.font              = nvNormalFontWithSize(16.0f + fontScale);
    label.textColor         = COLOR_HM_GRAY;
    label.textAlignment     = NSTextAlignmentCenter;
    label.numberOfLines     = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor   = [UIColor clearColor];
    
    NSMutableAttributedString* attributedString     = [[NSMutableAttributedString alloc] init];
    [attributedString appendString:@"网络连接失败" withAttributes:ATTR_DICTIONARY(COLOR_HM_BLACK, 18.0f + fontScale)];
    [attributedString addLine:2];
    [attributedString appendString:@"请检查您的手机是否联网" withAttributes:ATTR_DICTIONARY(COLOR_HM_LIGHT_BLACK, 14.0f + fontScale)];
    label.attributedText    = attributedString;
    
    
    NVButton* button        = [[NVButton alloc] initWithFrame:CGRectMake((APPLICATIONWIDTH - 100.0f)/2,
                                                                         APPLICATIONHEIGHT/2 + 80.0f,
                                                                         100.0f,
                                                                         30.0f)];
    [exceptionView addSubview:button];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_HM_BLACK forState:UIControlStateNormal];
    button.titleLabel.font  = nvNormalFontWithSize(14.0f + fontScale);
    button.normalColor      = COLOR_HM_BLACK;
    button.buttonStyle      = NVButtonStyleBorder;
    [button addTarget:self action:@selector(onTryAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:exceptionView];
}


- (void) showNullDataView {
    [self showNullDataViewInView:self.view];
}

- (void) showNullDataViewInView:(UIView *)view {
    UIView* exceptionView = [self exceptionViewInView:view];
    
    CGRect frame = view.frame;
    exceptionView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 76.0f * displayScale)/2,
                                                                           frame.size.height/4,
                                                                           76.0f * displayScale,
                                                                           66.0f * displayScale)];
    [exceptionView addSubview:imageView];
    imageView.image     = [self imageOfNullDataView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGSize size         = imageView.image.size;
    imageView.frame     = CGRectMake((frame.size.width - size.width)/2, frame.size.height/4, size.width, size.height);
    
    NVLabel* label      = [[NVLabel alloc] initWithFrame:CGRectMake(30.0f,
                                                                    frame.size.height/4 + size.height + 5.0f,
                                                                    frame.size.width - 60.0f,
                                                                    30.0f)];
    [exceptionView addSubview:label];
    label.font          = nvNormalFontWithSize(16.0f + fontScale);
    label.textColor     = COLOR_HM_GRAY;
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText= [self titleOfNullDataView];

    //只有搜索的时候才有清空按钮
//    if ([label.text isEqualToString:@"抱歉,未找到相关搜索客户"]) {
//        NVButton* button        = [[NVButton alloc] initWithFrame:CGRectMake((APPLICATIONWIDTH - 120.0f)/2,
//                                                                             CGRectGetMaxY(label.frame)+20.0f,
//                                                                             120.0f,
//                                                                             30.0f)];
//        [exceptionView addSubview:button];
//        [button setTitle:@"清空搜索条件" forState:UIControlStateNormal];
//        [button setTitleColor:COLOR_HM_BLACK forState:UIControlStateNormal];
//        button.titleLabel.font  = nvNormalFontWithSize(14.0f + fontScale);
//        button.normalColor      = COLOR_HM_BLACK;
//        button.buttonStyle      = NVButtonStyleBorder;
//        [button addTarget:self action:@selector(onRestartLoad:) forControlEvents:UIControlEventTouchUpInside];
//        
//
//    }
    
    [view addSubview:exceptionView];
    
    [self nullDataViewExtention:exceptionView];
    
}


- (void) tryAgainAtExceptionView {
    
}

- (void) reloadAtNullView {
    
}

- (void) hideExceptionView {
    UIView* exceptionView = [self.view viewWithTag:TAG_OF_EXCEPTION_VIEW];
    if (exceptionView != nil) {
        [exceptionView removeFromSuperview];
    }
}

- (UIImage*) imageOfNullDataView {
    return [UIImage imageNamed:@"img_null.png"];
}


- (NSAttributedString*) titleOfNullDataView {
    NSAttributedString* attributedString    = [[NSAttributedString alloc] initWithString:@"暂无数据"
                                                                              attributes:ATTR_DICTIONARY(COLOR_HM_LIGHT_BLACK, 14.0f + fontScale)];
    
    return attributedString;
}

- (void) nullDataViewExtention:(UIView*)exceptionView {
    
}


#pragma mark - private
- (UIView*) exceptionViewInView:(UIView*)view {
    UIView* exceptionView = [view viewWithTag:TAG_OF_EXCEPTION_VIEW];
    if (exceptionView == nil) {
        
        exceptionView       = [[UIView alloc] initWithFrame:view.bounds];
        exceptionView.tag   = TAG_OF_EXCEPTION_VIEW;

    }
    
    [exceptionView removeFromSuperview];
    
    NSArray* subViews = exceptionView.subviews;
    for (UIView* view in subViews) {
        [view removeFromSuperview];
    }
    
    return exceptionView;
}

- (void) onTryAgain:(id)sender {
    [self tryAgainAtExceptionView];
}

- (void) onRestartLoad:(id)sender {
    [self reloadAtNullView];
}

@end
