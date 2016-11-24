//
//  VSSheetView.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/17.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSInteger const kVSSheetViewTag;

/**
 按钮点击后触发

 @param buttonIndex 按钮的tag，取消按钮tag为0
 */
typedef void(^VSSheetViewCallBackBlock)(NSInteger buttonIndex);

/**
 仿微信弹出选择相机/相册/小视频
 */
@interface VSSheetView : UIView


/**
 多个按钮组合，从屏幕下方弹出

 @param titles      多个按钮标题数组
 @param cancelTitle 取消按钮标题
 @param callback    回调

 @return SheetView实例
 */
+ (VSSheetView *)ShowWithbuttonTitles:(NSArray *)titles
                          cancelTitle:(NSString *)cancelTitle
                            callBlock:(VSSheetViewCallBackBlock)callback;

/**
 高度同定制视图高度一致，宽度为屏幕宽度，从屏幕下方出来。

 @param customView 定制视图
 @param callback   回调

 @return SheetView实例
 */
+ (VSSheetView *)ShowWithCustomView:(UIView *)customView
                          callBlock:(VSSheetViewCallBackBlock)callback;

@end
