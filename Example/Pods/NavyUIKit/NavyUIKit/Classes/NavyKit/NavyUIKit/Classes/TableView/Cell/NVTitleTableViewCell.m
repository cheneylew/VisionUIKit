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
    }
    
    return self;
}

@end


@interface NVTitleTableViewCell ()
@property (nonatomic, strong) NVLabel* uiTitle;
@end


#define CELL_HEIGHT         40.0f


@implementation NVTitleTableViewCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
        
    }
    
    return self;
}


- (void) setObject:(id)object {
    if (self.item != object && object != nil) {
        self.item = object;
    }
    
    NVTitleDataModel* dataModel     = (NVTitleDataModel*)self.item;
    
    self.uiTitle.textAlignment      = dataModel.textAlignment;
    if ([dataModel.title isKindOfClass:[NSString class]]) {
        self.uiTitle.text               = dataModel.title;
        if (dataModel.titleColor) {
            self.uiTitle.textColor      = dataModel.titleColor;
        }
        self.uiTitle.font               = nvNormalFontWithSize(dataModel.fontSize);
        self.uiTitle.numberOfLines      = 0;
        
        
        CGSize size = [self.uiTitle.text boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 20.0f, 1000000.0f)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:ATTR_DICTIONARY3(COLOR_HM_LIGHT_BLACK, self.uiTitle.font)
                                                      context:nil].size;
        
        CGRect frame            = self.uiTitle.frame;
        frame.size.height       = size.height;
        self.uiTitle.frame      = frame;
    
    } else if ([dataModel.title isKindOfClass:[NSAttributedString class]]) {
        NSAttributedString* attributeString = dataModel.title;
        self.uiTitle.attributedText     = attributeString;
        
        CGSize size = [attributeString boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 20.0f, 1000000.0f)
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    context:nil].size;
        
        CGRect frame            = self.uiTitle.frame;
        frame.size.height       = size.height;
        self.uiTitle.frame      = frame;
    }
    
    dataModel.cellInstance      = self;
    
}

- (void) updateDisplay {
    [self setObject:self.item];
}


+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    NVTitleDataModel* dataModel     = (NVTitleDataModel*)object;
    
    CGSize size;
    if ([dataModel.title isKindOfClass:[NSString class]]) {
        size = [dataModel.title boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 20.0f, 1000000.0f)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:ATTR_DICTIONARY(COLOR_HM_LIGHT_BLACK, dataModel.fontSize)
                                               context:nil].size;
        
    } else if ([dataModel.title isKindOfClass:[NSAttributedString class]]) {
        NSAttributedString* attributeString = dataModel.title;
        
        size = [attributeString boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 20.0f, 1000000.0f)
                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             context:nil].size;

    }
    
    
    return size.height + 10.0f;
}


+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}

@end

