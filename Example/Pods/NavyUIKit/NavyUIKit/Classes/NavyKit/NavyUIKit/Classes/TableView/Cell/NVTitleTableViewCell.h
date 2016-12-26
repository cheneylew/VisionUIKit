//
//  NVTitleTableViewCell.h
//  Navy
//
//  Created by Jelly on 6/28/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"


@interface NVTitleDataModel : NVDataModel

@property (nonatomic, strong) id title;                     //标题字符串，可以为NSString或NSAttributedString
@property (nonatomic, strong) UIColor* titleColor;          //文字颜色
@property (nonatomic, assign) NSTextAlignment textAlignment;//对齐方式
@property (nonatomic, assign) CGFloat fontSize;             //字体大小
@property (nonatomic, assign) BOOL closeAutoAdjustHeight;   //默认开启自适应高度
@property (nonatomic, assign) UIEdgeInsets titleEdgeInset;  //默认UIEdgeInsetsMake(5, 10, 5, 10)
@property (nonatomic, assign) BOOL tagLineHidden;           //标题前面蓝色小竖线
@property (nonatomic, strong) UIColor *tagLineColor;        //

@end


@interface NVTitleTableViewCell : NVTableViewNullCell
- (void) updateDisplay;
@end


