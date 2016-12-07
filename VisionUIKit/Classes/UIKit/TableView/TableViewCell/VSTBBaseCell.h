//
//  VSTBBaseCell.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    VSTBCellSelectedStyleNone,
    VSTBCellSelectedStyleCustom,
} VSTBCellSelectedStyle;

@protocol VSTBBaseDataModelProtocal <NSObject>

@required
@property (nonatomic, strong) NSString  *classString;
@property (nonatomic, strong) NSString  *identifier;
@property (nonatomic, strong) NSNumber   *height;

@optional
@property (nonatomic, strong) UIColor *backgroudColor;

@end

@interface VSTBBaseDataModel : NSObject
<VSTBBaseDataModelProtocal>

@property (nonatomic, strong) NSString          *classString;           //类的字符串名称
@property (nonatomic, strong) NSString          *identifier;            //Cell重用的识别标识
@property (nonatomic, strong) NSNumber          *height;               //Cell高度，默认Fit6P(135)
@property (nonatomic, weak)   UIViewController  *controller; //指向所属的控制器


@property (nonatomic, assign) VSTBCellSelectedStyle selectedStyle;
@property (nonatomic, strong) UIColor               *backgroudColor;          //Cell背景色-默认白色
@property (nonatomic, strong) UIColor               *selectedBackgroudColor;  //Cell选中背景色-默认白色
@property (nonatomic, assign) BOOL                  detailArrowIcon;

@property (nonatomic, assign) BOOL      showGroupLine;                   //分组线
@property (nonatomic, strong) UIColor   *groupLineColor;
@property (nonatomic, strong) NSNumber  *groupLineLeft;
@property (nonatomic, strong) NSNumber  *groupLineRight;

@property (nonatomic, assign) BOOL      showTopLine;                   //顶部分割组线
@property (nonatomic, strong) UIColor   *topLineColor;
@property (nonatomic, assign) BOOL      showBottomLine;                //底部分割线
@property (nonatomic, strong) UIColor   *bottomLineColor;

@end

@protocol VSTBBaseCellProtocal <NSObject>

@required
- (void)initUI;
- (void)setModel:(VSTBBaseDataModel *)cellModel;

@end
@interface VSTBBaseCell : UITableViewCell
<VSTBBaseCellProtocal>

@property (nonatomic, weak) VSTBBaseDataModel *cellModel;

/**
 子类必须重写
 */
- (void)initUI;
- (void)setModel:(VSTBBaseDataModel *)cellModel;

@end
