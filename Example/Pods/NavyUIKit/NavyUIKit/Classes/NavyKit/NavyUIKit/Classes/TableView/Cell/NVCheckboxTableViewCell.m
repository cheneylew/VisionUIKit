//
//  NVCheckboxTableViewCell.m
//  Navy
//
//  Created by Jelly on 7/13/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVCheckboxTableViewCell.h"
#import "NSMutableAttributedString+Category.h"
#import "NavyUIKit.h"


@implementation NVCheckboxDataModel



@end

@interface NVCheckboxTableViewCell ()
@property (nonatomic, strong) UIControl* controlBg;
@property (nonatomic, strong) UIImageView* uiImageView;
@property (nonatomic, strong) NVLabel* uiTitle;
- (void) onCheck:(id)sender;
@end


#define CELL_HEIGHT     (42.0f * displayScale)

@implementation NVCheckboxTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor    = COLOR_DEFAULT_WHITE;
        self.selectionStyle     = UITableViewCellSelectionStyleNone;
        
        _uiImageView        = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, (CELL_HEIGHT - 19.0f)/2, 19.0f, 19.0f)];
        [self.contentView addSubview:_uiImageView];
        [_uiImageView setImage:[UIImage imageNamed:@"icon_checkbox_normal.png"]];
        
        
        _uiTitle            = [[NVLabel alloc] initWithFrame:CGRectMake(40.0f, (CELL_HEIGHT - 20.0f)/2, APPLICATIONWIDTH, 20.0f)];
        [self.contentView addSubview:_uiTitle];
        [_uiTitle setTextColor:COLOR_HM_DARK_GRAY];
        [_uiTitle setFont:nvNormalFontWithSize(14.0f)];
        [_uiTitle setText:@"使用账户余额进行支付:"];
        
        _controlBg          = [[UIControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH, CELL_HEIGHT)];
        [self.contentView addSubview:_controlBg];
        [_controlBg addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void) setObject:(id)object {
    [super setObject: object];
    
    NVCheckboxDataModel* dataModel = (NVCheckboxDataModel*)self.item;
    
    [_uiTitle setText:dataModel.title];
    
    if (!dataModel.selected && dataModel.imageNormal) {
        [_uiImageView setImage:dataModel.imageNormal];
    } else if (dataModel.selected && dataModel.imageSelected) {
        [_uiImageView setImage:dataModel.imageSelected];
    }
    
    self.delegate = dataModel.delegate;
}

- (void) onCheck:(id)sender {
    NVCheckboxDataModel* dataModel = (NVCheckboxDataModel*)self.item;
    dataModel.selected = !dataModel.selected;
    
    if (!dataModel.selected && dataModel.imageNormal) {
        [_uiImageView setImage:dataModel.imageNormal];
    } else if (dataModel.selected && dataModel.imageSelected) {
        [_uiImageView setImage:dataModel.imageSelected];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkboxTableViewCell:didChangeCheckboxState:)]) {
        [self.delegate checkboxTableViewCell:self didChangeCheckboxState:dataModel.selected];
    }
}

+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}

@end



#define CELL_HEIGHT2     (30.0f)

@implementation NVCheckboxTableViewCell2

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor    = [UIColor clearColor];
        self.selectionStyle     = UITableViewCellSelectionStyleNone;
        
        [self.lineLower removeFromSuperlayer];
        [self.lineUpper removeFromSuperlayer];
        
        self.uiImageView.frame  = CGRectMake(15.0f, (CELL_HEIGHT2 - 16.0f)/2, 16.0f, 16.0f);
        self.uiTitle.frame      = CGRectMake(40.0f, (CELL_HEIGHT2 - 20.0f)/2, APPLICATIONWIDTH, 20.0f);
        self.controlBg.frame    = CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH/2, CELL_HEIGHT2);
    }
    
    return self;
}

+ (CGFloat) heightForCell {
    return CELL_HEIGHT2;
}

@end


@implementation NVHyperlinkCheckboxDataModel

@end



@interface NVHyperlinkCheckboxTableViewCell ()
<UITextViewDelegate>
//<NVHyperlinkLabelDelegate>
//@property (nonatomic, strong) NVHyperlinkLabel* uiHyperlink;
@property (nonatomic, strong) UITextView* uiHyperlink;
@end

@implementation NVHyperlinkCheckboxTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.controlBg.frame    = CGRectMake(15.0f, (CELL_HEIGHT2 - 20.0f)/2, 20.0f, 20.0f);
        
        self.uiHyperlink = [[UITextView alloc] initWithFrame:CGRectMake(40.0f,
                                                                        0.0f,
                                                                        APPLICATIONWIDTH - 50.0f,
                                                                        CELL_HEIGHT2)];
        [self.contentView addSubview:self.uiHyperlink];
        self.uiHyperlink.backgroundColor= [UIColor clearColor];
        self.uiHyperlink.delegate       = self;
        self.uiHyperlink.editable       = NO;
        self.uiHyperlink.scrollEnabled  = NO;
        self.uiHyperlink.textContainer.lineFragmentPadding = 0;
        self.uiHyperlink.textContainerInset = UIEdgeInsetsMake(6.0f, 0.0f, 0.0f, 0.0f);
        self.uiHyperlink.dataDetectorTypes  = UIDataDetectorTypeNone;
        self.userInteractionEnabled     = YES;
        
    }
    return self;
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    NVHyperlinkCheckboxDataModel* dataModel = (NVHyperlinkCheckboxDataModel*)self.item;
    
    
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] init];
    
    [dataModel.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVHyperlinkItemDataModel* itemHyperlink = (NVHyperlinkItemDataModel*)obj;
        if ([itemHyperlink.urlPath length] == 0) {
            [attributedString appendString:itemHyperlink.text
                            withAttributes:ATTR_DICTIONARY(itemHyperlink.colorText, 14.0f)];
        } else {
            NSURL* url  = [NSURL URLWithString:itemHyperlink.urlPath];
            NSDictionary* dictionary = @{
                                         NSForegroundColorAttributeName : itemHyperlink.colorLink,
                                         NSFontAttributeName : nvNormalFontWithSize(14.0f),
                                         NSLinkAttributeName: url};
            [attributedString appendString:itemHyperlink.text withAttributes:dictionary];
            self.uiHyperlink.linkTextAttributes = @{NSForegroundColorAttributeName:itemHyperlink.colorLink};
        }
    }];
    
    self.uiHyperlink.attributedText = attributedString;
    
    
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 80.0f, 100000.0f)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics
                                                 context:nil].size;
    
    NSLog(@"%f", size.height);
    
    CGRect frame = self.uiHyperlink.frame;
    frame.size.height = size.height + 12.0f;
    self.uiHyperlink.frame = frame;
    
}



+ (CGFloat) heightForCell {
    return CELL_HEIGHT2;
}

+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    NVHyperlinkCheckboxDataModel* dataModel = (NVHyperlinkCheckboxDataModel*)object;
    
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] init];
    
    [dataModel.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVHyperlinkItemDataModel* itemHyperlink = (NVHyperlinkItemDataModel*)obj;
        if ([itemHyperlink.urlPath length] == 0) {
            [attributedString appendString:itemHyperlink.text
                            withAttributes:ATTR_DICTIONARY(itemHyperlink.colorText, 14.0f)];
        } else {
            NSURL* url  = [NSURL URLWithString:itemHyperlink.urlPath];
            NSDictionary* dictionary = @{NSLinkAttributeName: url,
                                         NSForegroundColorAttributeName : itemHyperlink.colorLink,
                                         NSFontAttributeName : nvNormalFontWithSize(14.0f)};
            [attributedString appendString:itemHyperlink.text withAttributes:dictionary];
            
        }
    }];
    
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 80.0f, 100000.0f)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics
                                                 context:nil].size;
    
    
    return size.height + 12.0f;

}


#pragma mark - NVHyperlinkLabelDelegate
- (void) hyperlinkLabel:(NVHyperlinkLabel *)label touchUrl:(NSString *)urlPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hyperlinkCheckboxTableViewCell:touchUrl:)]) {
        [self.delegate hyperlinkCheckboxTableViewCell:self
                                             touchUrl:urlPath];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hyperlinkCheckboxTableViewCell:touchUrl:)]) {
        [self.delegate hyperlinkCheckboxTableViewCell:self
                                             touchUrl:URL.absoluteString];
    }
    return NO;
}
@end

