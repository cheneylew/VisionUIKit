//
//  VSSheetView.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/17.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSInteger const kVSSheetViewTag;

typedef void(^VSSheetViewCallBackBlock)(NSInteger buttonIndex);

/**
 仿微信弹出选择相机/相册/小视频
 */
@interface VSSheetView : UIView

+ (VSSheetView *)ShowWithbuttonTitles:(NSArray *)titles
                          cancelTitle:(NSString *)cancelTitle
                            callBlock:(VSSheetViewCallBackBlock)callback;

+ (VSSheetView *)ShowWithCustomView:(UIView *)customView
                          callBlock:(VSSheetViewCallBackBlock)callback;

@end
