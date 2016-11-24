//
//  NVTagTableViewCell.m
//  Navy
//
//  Created by Jelly on 9/16/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTagTableViewCell.h"
#import "NVLabel.h"


@implementation NVTagDataModel

@end



@interface NVTagTableViewCell ()
@property (nonatomic, strong) NVLabel* uiTitle;
@property (nonatomic, strong) CALayer* layerTag;
@end


#define CELL_HEIGHT     BASE_CELL_HEIGHT


@implementation NVTagTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle     = UITableViewCellSelectionStyleDefault;
        self.backgroundColor    = COLOR_DEFAULT_WHITE;
        
        
        _uiTitle = [[NVLabel alloc] initWithFrame:CGRectMake(20.0f, (CELL_HEIGHT - 20.0f)/2, 260.0f, 20.0f)];
        [self.contentView addSubview:_uiTitle];
        [_uiTitle setTextColor:[UIColor grayColor]];
        [_uiTitle setFont:nvNormalFontWithSize(16.0f + fontScale)];
        
        
        self.layerTag           = [CALayer layer];
        [self.contentView.layer insertSublayer:self.layerTag atIndex:0];
        self.layerTag.frame     = CGRectMake(0.0f, 0.0f, 5.0f, CELL_HEIGHT);
    }
    
    return self;
}

- (void) setObject:(id)object {
    if (self.item != object && object != nil) {
        self.item = object;
    }
    
    NVTagDataModel* dataModel = (NVTagDataModel*)self.item;
    
    self.uiTitle.text       = dataModel.title;
    self.uiTitle.textColor  = dataModel.titleColor;
    
    self.uiTitle.textColor          = (dataModel.selected) ? dataModel.selectionColor : dataModel.titleColor;
    self.layerTag.hidden            = !dataModel.selected;
    self.layerTag.backgroundColor   = dataModel.selectionColor.CGColor;
    
    dataModel.cellInstance = self;
}

- (void) updateDisplay {
    [self setObject:self.item];
}

+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}

@end

