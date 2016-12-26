//
//  NVColumnTableViewCell.m
//  Navy
//
//  Created by Steven.Lin on 23/3/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVColumnTableViewCell.h"


@interface NVColumnButton : UIButton
@property (nonatomic, strong) UIImageView* uiImageView;
@property (nonatomic, strong) NVLabel* label;
@end


@implementation NVColumnButton

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.uiImageView      = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/4,
                                                                            frame.size.height/4,
                                                                            frame.size.width/2,
                                                                            frame.size.height/2)];
        [self addSubview:self.uiImageView];
        self.uiImageView.contentMode  = UIViewContentModeScaleAspectFit;
        
        
        self.label          = [[NVLabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                        CGRectGetMaxX(self.imageView.frame),
                                                                        frame.size.width,
                                                                        20.0f)];
        [self addSubview:self.label];
        self.label.textColor        = COLOR_HM_GRAY;
        self.label.textAlignment    = NSTextAlignmentCenter;
        self.label.font             = nvNormalFontWithSize(12.0f + fontScale);
        
    }
    
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGSize szView   = self.frame.size;
    CGSize size     = self.uiImageView.image.size;
    if (size.width > szView.width - 20.0f ||
        size.height > szView.height - 20.0f) {
        size.width  = szView.width - 20.0f;
        size.height = szView.height - 20.0f;
    }
    CGRect frame    = self.uiImageView.frame;
    
    frame.size      = size;
    frame.origin    = CGPointMake((self.frame.size.width - size.width)/2, (self.frame.size.height - size.height)/2);
    self.uiImageView.frame = frame;
    
    frame           = self.label.frame;
    frame.origin.y  = CGRectGetMaxY(self.uiImageView.frame) + 10.0f;
    self.label.frame= frame;
}

@end



@interface NVColumnDataModel ()
@property (nonatomic, weak) NVColumnButton* button;
@end

@implementation NVColumnDataModel 

- (void) setImage:(UIImage *)image {
    _image = image;
    
    self.button.uiImageView.image   = image;
    self.button.label.text          = @"";
    
    if (self.button) {
        [self.button setNeedsLayout];
    }
}

@end


@implementation NVColumnListModel

@end





@interface NVColumnTableViewCell ()
- (void) onClick:(id)sender;
@end


#define CELL_HEIGHT     (120.0f * displayScale)

@implementation NVColumnTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor        = COLOR_DEFAULT_WHITE;
        self.selectionStyle         = UITableViewCellSelectionStyleNone;
        
        
    }
    
    return self;
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];

    
    
    NVColumnListModel* listModel    = (NVColumnListModel*)self.item;
    self.delegate                   = listModel.delegate;
    
    if ([listModel.items count] > 0) {
        NVColumnDataModel* item     = [listModel.items objectAtIndex:0];
        UIImage* image              = [UIImage imageNamed:item.imageNamed];
        
        const CGFloat width         = APPLICATIONWIDTH / [listModel.items count];
        const CGFloat height        = (CELL_HEIGHT/2 < image.size.height) ? image.size.height*2 : CELL_HEIGHT;
        __block CGFloat x           = 0.0f;
        [listModel.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NVColumnDataModel* item = (NVColumnDataModel*)obj;
            
            
            NVColumnButton* button  = [[NVColumnButton alloc] initWithFrame:CGRectMake(x, 0.0f, width, height)];
            [self.contentView addSubview:button];
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag                  = idx;
            button.label.text           = item.title;
            button.uiImageView.image    = [UIImage imageNamed:item.imageNamed];
            item.button                 = button;
            [button layoutIfNeeded];
            
            x += width;
            
            CALayer* line           = [CALayer layer];
            [self.contentView.layer addSublayer:line];
            line.frame              = CGRectMake(x,
                                                 20.0f * displayScale,
                                                 0.5f,
                                                 height - 40.0f *displayScale);
            line.backgroundColor    = COLOR_LINE.CGColor;
            
        }];
    }
    
}

+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}

+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    NVColumnListModel* listModel    = (NVColumnListModel*)object;
    CGFloat height                  = CELL_HEIGHT;
    
    if ([listModel.items count] > 0) {
        NVColumnDataModel* item     = [listModel.items objectAtIndex:0];
        UIImage* image              = [UIImage imageNamed:item.imageNamed];
        if (CELL_HEIGHT/2 < image.size.height) {
            height = image.size.height*2;
        }
    }
    
    return height;
}

- (void) onClick:(id)sender {
    NSInteger index = ((UIButton*)sender).tag;
    
    NVColumnListModel* listModel    = (NVColumnListModel*)self.item;
    NVColumnDataModel* item         = [listModel.items objectAtIndex:index];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(columnTableViewCell:didClickItem:)]) {
        [self.delegate columnTableViewCell:self didClickItem:item];
    }
}


@end


