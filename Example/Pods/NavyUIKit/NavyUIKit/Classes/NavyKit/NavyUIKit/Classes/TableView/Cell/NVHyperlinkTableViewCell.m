//
//  NVHyperlinkTableViewCell.m
//  Navy
//
//  Created by Jelly on 7/12/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVHyperlinkTableViewCell.h"


@implementation NVHyperlinkItemDataModel

@end


@implementation NVHyperlinkDataModel


@end


@interface NVHyperlinkTableViewCell ()
<NVHyperlinkLabelDelegate>
@property (nonatomic, strong) NVHyperlinkLabel* uiHyperlink;
@end


#define CELL_HEIGHT     (30.0f * displayScale)


@implementation NVHyperlinkTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _uiHyperlink = [[NVHyperlinkLabel alloc] initWithFrame:CGRectMake(20.0f * displayScale,
                                                                          0.0f,
                                                                          APPLICATIONWIDTH - 40.0f * displayScale,
                                                                          CELL_HEIGHT)];
        [self.contentView addSubview:_uiHyperlink];
        _uiHyperlink.delegate = self;
        
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void) setObject:(id)object {
    if (self.item != object && object != nil) {
        self.item = object;
    }
    
    NVHyperlinkDataModel* dataModel = (NVHyperlinkDataModel*)self.item;
    
    [_uiHyperlink clear];
    
    
    [dataModel.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NVHyperlinkItemDataModel* itemHyperlink = (NVHyperlinkItemDataModel*)obj;
        UIColor* colorHyperLink     = COLOR_HM_BLUE;
        UIColor* colorPlainText     = COLOR_DEFAULT_WHITE;
        if (itemHyperlink.colorLink) {
            colorHyperLink          = itemHyperlink.colorLink;
        }
        if (itemHyperlink.colorText) {
            colorPlainText          = itemHyperlink.colorText;
        }
        
        if ([itemHyperlink.urlPath length] == 0) {
            [_uiHyperlink addAttributedPlainText:ATTRSTRING(itemHyperlink.text, ATTR_DICTIONARY(colorPlainText, 12.0f + fontScale))];
        } else {
            [_uiHyperlink addAttributedHyperlink:ATTRSTRING(itemHyperlink.text, ATTR_DICTIONARY(colorHyperLink, 12.0f + fontScale)) withUrl:itemHyperlink.urlPath];
        }
    }];
    

    self.uiHyperlink.textAlignment          = dataModel.textAlignment;
    self.delegate                           = dataModel.delegate;
}


#pragma mark - NVHyperlinkLabelDelegate
- (void) hyperlinkLabel:(NVHyperlinkLabel *)label touchUrl:(NSString *)urlPath {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(hyperlinkTableViewCell:didClickUrlPath:)]) {
        [self.delegate hyperlinkTableViewCell:self didClickUrlPath:urlPath];
    }
}


+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}


@end

