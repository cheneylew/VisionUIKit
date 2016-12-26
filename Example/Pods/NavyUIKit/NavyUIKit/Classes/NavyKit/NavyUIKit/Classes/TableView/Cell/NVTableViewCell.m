//
//  NVTableViewCell.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewCell.h"

#define NVTableViewCell_DEF_BGCOLOR [UIColor whiteColor]

@interface NVTableViewCell ()

PP_IMAGEVIEW(arrow_icon)
PP_VIEW(groupLine)
PP_VIEW(topLine)
PP_VIEW(bottomLine)

@end

@implementation NVTableViewCell

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
    arrowIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    arrowIcon.hidden = YES;
    self.arrow_icon = arrowIcon;
    [self addSubview:arrowIcon];
}


#pragma mark - height
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    CGFloat height = 0;
    
    if ([object conformsToProtocol:@protocol(NVTableViewCellItemProtocol)]) {
        if ([object respondsToSelector:@selector(cellHeight)]) {
            if ([object cellHeight]) {
                height = [[object cellHeight] floatValue];
            }
        }
    }
    
    return height;
}

- (void) setObject:(id)object {
    if (_item != object && object != nil) {
        _item = object;
    }
    
    self.backgroundColor = self.item.normalBackgroudColor?self.item.normalBackgroudColor:NVTableViewCell_DEF_BGCOLOR;
    
    // config display cell
    if (self.item.showGroupLine) {
        self.groupLine.hidden = NO;
        self.groupLine.bottom = [[self.item cellHeight] floatValue];
        if (self.item.groupLineLeft && self.item.groupLineRight) {
            self.groupLine.left = self.item.groupLineLeft.floatValue;
            self.groupLine.width = self.width-self.item.groupLineLeft.floatValue-self.item.groupLineRight.floatValue;
        }else if(self.item.groupLineLeft) {
            self.groupLine.left = self.item.groupLineLeft.floatValue;
            self.groupLine.width = self.width-self.self.groupLine.left;
        }else if(self.item.groupLineRight) {
            self.groupLine.left = 0;
            self.groupLine.width = self.width - self.item.groupLineRight.floatValue;
        }
    }else {
        self.groupLine.hidden = YES;
    }
    
    if (self.item.showTopLine) {
        self.topLine.hidden = NO;
    }else {
        self.topLine.hidden = YES;
    }
    
    if (self.item.showBottomLine) {
        self.bottomLine.hidden = NO;
        self.bottomLine.bottom = [[self.item cellHeight] floatValue];
    }else {
        self.bottomLine.hidden = YES;
    }
    
    if (self.item.detailArrowIcon) {
        self.arrow_icon.hidden = NO;
        self.arrow_icon.right= self.width-FIT6P(47);
        self.arrow_icon.centerY = [[self.item cellHeight] floatValue]/2;
    }else {
        self.arrow_icon.hidden = YES;
    }
}


+ (NSString*) cellIdentifier {
    return @"theDefaultCell";
}

+ (CGFloat) heightForCell {
    return 32.0f;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.item.selectedStyle == NVTBCellSelectedStyleCustom) {
        self.backgroundColor = self.item.selectedBackgroudColor;
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.item.selectedStyle == NVTBCellSelectedStyleCustom) {
        WEAK_SELF;
        [UIView animateWithDuration:0.5 animations:^{
            weakself.backgroundColor = weakself.item.normalBackgroudColor?weakself.item.normalBackgroudColor:NVTableViewCell_DEF_BGCOLOR;
        }];
    }
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.item.selectedStyle == NVTBCellSelectedStyleCustom) {
        WEAK_SELF;
        [UIView animateWithDuration:0.5 animations:^{
            weakself.backgroundColor = weakself.item.normalBackgroudColor?weakself.item.normalBackgroudColor:NVTableViewCell_DEF_BGCOLOR;
        }];
    }
    [super touchesCancelled:touches withEvent:event];
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
        _groupLine.backgroundColor = self.item.groupLineColor;
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
        _topLine.backgroundColor = self.item.topLineColor?self.item.topLineColor:[UIColor lightGrayColor];
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
        _bottomLine.backgroundColor = self.item.topLineColor?self.item.bottomLineColor:[UIColor lightGrayColor];
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end


