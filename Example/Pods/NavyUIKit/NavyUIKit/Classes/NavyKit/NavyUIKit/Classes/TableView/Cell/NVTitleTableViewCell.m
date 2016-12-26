//
//  NVTitleTableViewCell.m
//  Navy
//
//  Created by Jelly on 6/28/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTitleTableViewCell.h"
#import "NVLabel.h"


@implementation NVTitleDataModel

- (id) init {
    self = [super init];
    if (self) {
        self.fontSize       = 14.0f;
        self.textAlignment  = NSTextAlignmentCenter;
        self.titleEdgeInset = UIEdgeInsetsMake(5, 10, 5, 10);
        self.tagLineHidden  = YES;
        self.tagLineColor   = HEX(0x0088ec);
    }
    
    return self;
}

@end


@interface NVTitleTableViewCell ()
@property (nonatomic, strong) NVLabel* uiTitle;
@property (nonatomic, strong) UIView *tagLine;
@end


#define CELL_HEIGHT         40.0f


@implementation NVTitleTableViewCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (void)initUI {
    [super initUI];
    
    self.backgroundColor            = [UIColor clearColor];
    self.selectionStyle             = UITableViewCellSelectionStyleNone;
    
    
    self.uiTitle                    = [[NVLabel alloc] initWithFrame:CGRectMake(10.0f,
                                                                                5.0f,
                                                                                APPLICATIONWIDTH - 20.0f,
                                                                                CELL_HEIGHT - 20.0f)];
    [self.contentView addSubview:self.uiTitle];
    self.uiTitle.font               = nvNormalFontWithSize(14.0f);
    self.uiTitle.textAlignment      = NSTextAlignmentCenter;
    self.uiTitle.textColor          = COLOR_HM_LIGHT_BLACK;
    
    UIView *tagLine = [[UIView alloc] initWithFrame:CGRectMake(fit6(30), 0, fit6(4), fit6(27))];
    tagLine.hidden  = YES;
    [self addSubview:tagLine];
    self.tagLine = tagLine;
}


- (void) setObject:(id)object {
    [super setObject:object];
    
    NVTitleDataModel* dataModel     = (NVTitleDataModel*)self.item;
    
    self.uiTitle.textAlignment      = dataModel.textAlignment;
    if ([dataModel.title isKindOfClass:[NSString class]]) {
        self.uiTitle.text               = dataModel.title;
        if (dataModel.titleColor) {
            self.uiTitle.textColor      = dataModel.titleColor;
        }
        self.uiTitle.font               = nvNormalFontWithSize(dataModel.fontSize);
        self.uiTitle.numberOfLines      = 0;
        
        CGFloat x = dataModel.titleEdgeInset.left;
        CGFloat y = dataModel.titleEdgeInset.top;
        CGFloat w = self.width - dataModel.titleEdgeInset.left - dataModel.titleEdgeInset.right;
        CGFloat h = [self.uiTitle.text jk_heightWithFont:self.uiTitle.font constrainedToWidth:w];
        
        self.uiTitle.frame      = CGRectMake(x, y, w, h);
    
    } else if ([dataModel.title isKindOfClass:[NSAttributedString class]]) {
        NSAttributedString* attributeString = dataModel.title;
        self.uiTitle.attributedText     = attributeString;
        
        CGFloat x = dataModel.titleEdgeInset.left;
        CGFloat y = dataModel.titleEdgeInset.top;
        CGFloat w = self.width - dataModel.titleEdgeInset.left - dataModel.titleEdgeInset.right;
        CGFloat h = [attributeString boundingRectWithSize:CGSizeMake(w, 1000000.0f)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                  context:nil].size.height;
        self.uiTitle.frame      = CGRectMake(x, y, w, h);
    }
    
    dataModel.cellInstance      = self;
    
    if (dataModel.closeAutoAdjustHeight) {
        self.uiTitle.centerY = dataModel.cellHeight.floatValue/2;
    }
    
    if (dataModel.tagLineHidden) {
        self.tagLine.hidden = YES;
    }else {
        self.tagLine.hidden = NO;
        self.tagLine.backgroundColor = dataModel.tagLineColor;
        self.tagLine.centerY = self.uiTitle.top + self.uiTitle.height/2;
    }
}

- (void) updateDisplay {
    [self setObject:self.item];
}


+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    NVTitleDataModel* dataModel     = (NVTitleDataModel*)object;
    
    if (dataModel.closeAutoAdjustHeight) {
        return [super tableView:tableView rowHeightForObject:object];
    }else {
        CGFloat w = SCREEN_WIDTH - dataModel.titleEdgeInset.left - dataModel.titleEdgeInset.right;
        CGSize size;
        if ([dataModel.title isKindOfClass:[NSString class]]) {
            size = [dataModel.title boundingRectWithSize:CGSizeMake(w, 1000000.0f)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:ATTR_DICTIONARY(COLOR_HM_LIGHT_BLACK, dataModel.fontSize)
                                                 context:nil].size;
            
        } else if ([dataModel.title isKindOfClass:[NSAttributedString class]]) {
            NSAttributedString* attributeString = dataModel.title;
            
            size = [attributeString boundingRectWithSize:CGSizeMake(w, 1000000.0f)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 context:nil].size;
            
        }
        
        
        return size.height + 10.0f;
    }
}


//+ (CGFloat) heightForCell {
//    return CELL_HEIGHT;
//}

@end

