//
//  VSBaseTableViewCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSBaseTableViewCell.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>
#import "UIImage+Bundle.h"

@implementation VSTBBaseDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedStyle = VSTBCellSelectedStyleCustom;
    }
    return self;
}

@end

@interface VSBaseTableViewCell ()

PP_IMAGEVIEW(arrow_icon)
PP_VIEW(groupLine)
PP_VIEW(topLine)
PP_VIEW(bottomLine)

@end

@implementation VSBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIImageView *arrowIcon = [[UIImageView alloc] initWithImage:[UIImage vs_imageName:@"vs_arrow_icon"]];
    arrowIcon.frame = CGRectMake(0, 0, FIT6P(24), FIT6P(42));
    arrowIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.arrow_icon = arrowIcon;
    [self addSubview:arrowIcon];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.cellModel.selectedStyle == VSTBCellSelectedStyleCustom) {
        self.backgroundColor = self.cellModel.selectedBackgroudColor;
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.cellModel.selectedStyle == VSTBCellSelectedStyleCustom) {
        WEAK_SELF;
        [UIView animateWithDuration:0.5 animations:^{
            weakself.backgroundColor = self.cellModel.backgroudColor;
        }];
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.cellModel.selectedStyle == VSTBCellSelectedStyleCustom) {
        WEAK_SELF;
        [UIView animateWithDuration:0.5 animations:^{
            weakself.backgroundColor = self.cellModel.backgroudColor;
        }];
        [super touchesCancelled:touches withEvent:event];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UIView *)groupLine {
    if (_groupLine == nil) {
        _groupLine = [[UIView alloc] initWithFrame:CGRectMake(FIT6P(60),
                                                                     0,
                                                                     self.width-FIT6P(60),
                                                                     0.5)];
        _groupLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _groupLine.backgroundColor = self.cellModel.groupLineColor;
        [self addSubview:_groupLine];
    }
    return _groupLine;
}

- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            self.width,
                                                            0.5)];
        _topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _topLine.backgroundColor = self.cellModel.topLineColor?self.cellModel.topLineColor:[UIColor lightGrayColor];
        [self addSubview:_topLine];
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            self.width,
                                                            0.5)];
        _bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _bottomLine.backgroundColor = self.cellModel.topLineColor?self.cellModel.bottomLineColor:[UIColor lightGrayColor];
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (void)setModel:(VSTBBaseDataModel *)cellModel {
    if (_cellModel != cellModel) {
        _cellModel = cellModel;
    }
    // config display cell
    if (cellModel.showGroupLine) {
        self.groupLine.hidden = NO;
        self.groupLine.bottom = self.cellModel.height.floatValue;
        if (self.cellModel.groupLineLeft && self.cellModel.groupLineRight) {
            self.groupLine.left = self.cellModel.groupLineLeft.floatValue;
            self.groupLine.width = self.width-self.cellModel.groupLineLeft.floatValue-self.cellModel.groupLineRight.floatValue;
        }else if(self.cellModel.groupLineLeft) {
            self.groupLine.left = self.cellModel.groupLineLeft.floatValue;
            self.groupLine.width = self.width-self.self.groupLine.left;
        }else if(self.cellModel.groupLineRight) {
            self.groupLine.left = 0;
            self.groupLine.width = self.width - self.cellModel.groupLineRight.floatValue;
        }
    }else {
        self.groupLine.hidden = YES;
    }
    
    if (cellModel.showTopLine) {
        self.topLine.hidden = NO;
    }else {
        self.topLine.hidden = YES;
    }
    
    if (cellModel.showBottomLine) {
        self.bottomLine.hidden = NO;
        self.bottomLine.bottom = self.cellModel.height.floatValue;
    }else {
        self.bottomLine.hidden = YES;
    }
    
    if (cellModel.detailArrowIcon) {
        self.arrow_icon.hidden = NO;
        self.arrow_icon.right= self.width-FIT6P(47);
        self.arrow_icon.centerY = cellModel.height.floatValue/2;
    }else {
        self.arrow_icon.hidden = YES;
    }
}

@end
