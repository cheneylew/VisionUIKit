//
//  NVIconSheetTableViewCell.m
//  xiaochunlaile
//
//  Created by Steven.Lin on 27/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVIconSheetTableViewCell.h"
#import "NavyUIKit.h"


@implementation NVIconSheetDataModel

@end



@interface NVIconSheetTableViewCell ()
@property (nonatomic, strong) UIImageView* uiIconView;
@end


#define CELL_HEIGHT     BASE_CELL_HEIGHT


@implementation NVIconSheetTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor        = COLOR_DEFAULT_WHITE;
        self.selectionStyle         = UITableViewCellSelectionStyleNone;
        
        self.uiIconView             = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f,
                                                                                    (CELL_HEIGHT - 20.0f)/2,
                                                                                    20.0f,
                                                                                    20.0f)];
        [self.contentView addSubview:self.uiIconView];
        self.uiIconView.contentMode = UIViewContentModeScaleAspectFit;
        self.uiIconView.image       = [UIImage imageNamed:@"icon_info_manage.png"];
        
        
        CGRect frame                = _uiTitle.frame;
        frame.origin.x              = 30.0f + 10.0f;
        _uiTitle.frame              = frame;
        
    }
    
    return self;
}


- (void) setObject:(id)object {
    [super setObject:object];
    
    NVIconSheetDataModel* dataModel     = (NVIconSheetDataModel*)self.item;
    
    self.uiIconView.image               = [UIImage imageNamed:dataModel.imageNamed];
    
}


+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}

@end

