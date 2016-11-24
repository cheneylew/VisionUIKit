//
//  VSTBTableViewCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBTableViewCell.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

@interface VSTBTableViewCell ()

PP_IMAGEVIEW(arrow_icon)
PP_VIEW(speratedLine)
@property (nonatomic, weak) VSTBDataModel *cellModel;

@end

@implementation VSTBTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIImageView *arrowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_icon"]];
    arrowIcon.frame = CGRectMake(0, 0, FIT6P(24), FIT6P(42));
    self.arrow_icon = arrowIcon;
    [self addSubview:arrowIcon];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = self.cellModel.selectedBackgroudColor;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WEAK_SELF;
    [UIView animateWithDuration:0.5 animations:^{
        weakself.backgroundColor = self.cellModel.backgroudColor;
    }];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WEAK_SELF;
    [UIView animateWithDuration:0.5 animations:^{
        weakself.backgroundColor = self.cellModel.backgroudColor;
    }];
    [super touchesCancelled:touches withEvent:event];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UIView *)groupLine {
    if (!self.speratedLine) {
        self.speratedLine = [[UIView alloc] initWithFrame:CGRectMake(FIT6P(60),
                                                                     0,
                                                                     self.width-FIT6P(60),
                                                                     0.5)];
        self.speratedLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.speratedLine.backgroundColor = self.cellModel.groupLineColor;
        [self addSubview:self.speratedLine];
    }
    return self.speratedLine;
}

- (void)setCellModel:(VSTBDataModel *)cellModel {
    if (_cellModel != cellModel) {
        _cellModel = cellModel;
    }
    // config display cell
    if (cellModel.groupLine) {
        [self groupLine].hidden = NO;
        self.speratedLine.bottom = self.cellModel.height.floatValue;
    }else {
        [self groupLine].hidden = YES;
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
