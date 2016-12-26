//
//  NVSheetTableViewCell.m
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVSheetTableViewCell.h"
#import "NVLabel.h"
#import "NVTextField.h"
#import "UIView+Category.h"
#import "NavyUIKit.h"
#import "NVButton.h"







#define CELL_HEIGHT     BASE_CELL_HEIGHT

#define TAG_SHEET_CELL_FIELD            10001
#define TAG_SHEET_CELL_BUTTON           10002
#define TAG_SHEET_CELL_RIGHTBUTTON      10003

@interface NVSheetTableViewCell ()
<UITextFieldDelegate>
- (void) buttonAction:(id)sender;
- (void) notifierDidChange:(NSNotification*)notification;
- (void) notifierDidBeginEditing:(NSNotification *)notification;
- (void) notifierDidEndEditing:(NSNotification *)notification;
@end


@implementation NVSheetTableViewCell

- (void) dealloc {
    _delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierDidBeginEditing:)
                                                     name:UITextFieldTextDidBeginEditingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierDidEndEditing:)
                                                     name:UITextFieldTextDidEndEditingNotification
                                                   object:nil];
        
        [self setBackgroundColor:COLOR_DEFAULT_WHITE];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //        [self setSelectedBackgroundView:[[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, CELL_HEIGHT)] autorelease]];
        //        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        
        
        _uiTitle = [[NVLabel alloc] initWithFrame:CGRectMake(15.0f, (CELL_HEIGHT - 20.0f)/2, 260.0f, 20.0f)];
        [self.contentView addSubview:_uiTitle];
        [_uiTitle setTextColor:[UIColor grayColor]];
        [_uiTitle setFont:nvNormalFontWithSize(14.0f + fontScale)];
        
    }
    
    return self;
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    self.item.cellInstance = self;
    
    
    NVSheetDataModel* dataModel = (NVSheetDataModel*)self.item;
    
    if ([dataModel.title isKindOfClass:[NSString class]]) {
        _uiTitle.text   = dataModel.title;
    } else if ([dataModel.title isKindOfClass:[NSAttributedString class]]) {
        _uiTitle.attributedText = dataModel.title;
    }
    
    if (dataModel.titleColor) {
        [_uiTitle setTextColor:dataModel.titleColor];
    }
    
    _maxLength = dataModel.maxLength;
    
    switch (self.item.cellStyle) {
        case NVSheetTableViewCellStyleDefault:
            break;
        case NVSheetTableViewCellStyleEdit:
        case NVSheetTableViewCellStyleEdit2:
        {
            [self setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            _uiTitle.hidden = (self.item.cellStyle == NVSheetTableViewCellStyleEdit2);
            CGFloat x = (self.item.cellStyle == NVSheetTableViewCellStyleEdit2) ? 30.0f : 100.0f * displayScale;
            NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
            if (field == nil) {
                field = [[NVTextField alloc] initWithFrame:CGRectMake(x,
                                                                      (CELL_HEIGHT - 30.0f)/2,
                                                                      APPLICATIONWIDTH - 100 * displayScale - 15.f,
                                                                      30.0f)];
                [self.contentView addSubview:field];
                field.tag = TAG_SHEET_CELL_FIELD;
                
            }
            
            field.placeholder       = dataModel.placeHolder;
            field.placeHolderColor  = dataModel.placeHolderColor;
            field.textColor         = dataModel.valueColor;
            field.text              = dataModel.value;
            field.textAlignment     = dataModel.valueAlignment;
            field.font              = _uiTitle.font;
            field.keyboardType      = dataModel.keyboardType;
            field.tintColor         = dataModel.valueColor;
            field.delegate          = self;
            field.secureTextEntry   = dataModel.secureTextEntry;
            [field setEnabled:dataModel.enable];
            self.delegate           = dataModel.delegate;
            
            if (dataModel.valueFont) {
                field.font          = dataModel.valueFont;
                _uiTitle.font       = dataModel.valueFont;
            }
            
            break;
        }
        
        case NVSheetTableViewCellStyleEdit3:
        {
            [self setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            _uiTitle.hidden = (self.item.cellStyle == NVSheetTableViewCellStyleEdit2);
            CGFloat x = (self.item.cellStyle == NVSheetTableViewCellStyleEdit2) ? 30.0f : 100.0f * displayScale;
            NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
            if (field == nil) {
                field = [[NVTextField alloc] initWithFrame:CGRectMake(x,
                                                                      (CELL_HEIGHT - 30.0f)/2,
                                                                      APPLICATIONWIDTH - 100 * displayScale - 15.f*3,
                                                                      30.0f)];
                [self.contentView addSubview:field];
                field.tag = TAG_SHEET_CELL_FIELD;
                
            }
            
            field.placeholder       = dataModel.placeHolder;
            field.placeHolderColor  = dataModel.placeHolderColor;
            field.textColor         = dataModel.valueColor;
            field.text              = dataModel.value;
            field.textAlignment     = dataModel.valueAlignment;
            field.font              = _uiTitle.font;
            field.keyboardType      = dataModel.keyboardType;
            field.tintColor         = dataModel.valueColor;
            field.delegate          = self;
            field.secureTextEntry   = dataModel.secureTextEntry;
            [field setEnabled:dataModel.enable];
            self.delegate           = dataModel.delegate;
            
            if (dataModel.valueFont) {
                field.font          = dataModel.valueFont;
                _uiTitle.font       = dataModel.valueFont;
            }
            
            NVButton* rightButton = (NVButton*)[self.contentView viewWithTag:TAG_SHEET_CELL_RIGHTBUTTON];
            if (rightButton == nil) {
                rightButton = [[NVButton alloc] initWithFrame:CGRectMake(field.frame.origin.x + field.frame.size.width,
                                                                         (CELL_HEIGHT - 30.0f)/2,
                                                                         30.0f,
                                                                         30.0f)];
                [self.contentView addSubview:rightButton];
            }
            
            [rightButton setImage:dataModel.rightButtonIconImage forState:UIControlStateNormal];
            [rightButton addTarget:self action:@selector(rightButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
            
        case NVSheetTableViewCellStyleEditButton:
        {
            _uiBgView.hidden = NO;
            
            NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
            if (field) {
                field = [[NVTextField alloc] initWithFrame:CGRectMake(80.0f, (CELL_HEIGHT - 30.0f)/2, 230.0f, 30.0f)];
                [self.contentView addSubview:field];
                field.tag = TAG_SHEET_CELL_FIELD;
            }
            
            field.placeholder       = dataModel.placeHolder;
            field.placeHolderColor  = dataModel.placeHolderColor;
            field.textColor         = dataModel.titleColor;
            field.font              = _uiTitle.font;
            field.keyboardType      = dataModel.keyboardType;
            field.tintColor         = dataModel.valueColor;
            
            UIButton* button = (UIButton*)[self.contentView viewWithTag:TAG_SHEET_CELL_BUTTON];
            if (button) {
                button = [[UIButton alloc] initWithFrame:CGRectMake(80.0f, (CELL_HEIGHT - 30.0f)/2, 230.0f, 30.0f)];
                [self.contentView addSubview:button];
                button.tag = TAG_SHEET_CELL_BUTTON;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            self.delegate = dataModel.delegate;
            
            break;
        }
            
        case NVSheetTableViewCellStyleTitle:
        {
            
            _uiBgView.hidden = YES;
            _uiTitle.hidden = NO;
            [_uiTitle setTextAlignment:NSTextAlignmentCenter];
            [_uiTitle setTextColor:[UIColor grayColor]];
            
            NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
            if (field != nil) {
                [field removeFromSuperview];
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void) notifierDidChange:(NSNotification *)notification {
    
    NVTextField* fieldNotification = (NVTextField*)notification.object;
    NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
    
    if (_maxLength) {
        //当存在最大长度的时候
        if (field.text.length > _maxLength) {
            field.text = [field.text substringToIndex:_maxLength];
        }
    }
    
    if (field == fieldNotification) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sheetTableViewCell:textEditDidChangeValue:)]) {
            [self.delegate sheetTableViewCell:self textEditDidChangeValue:field.text];
        }
    }
    
}

- (void) notifierDidBeginEditing:(NSNotification *)notification {
    NVTextField* fieldNotification = (NVTextField*)notification.object;
    NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
    
    if (field == fieldNotification) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sheetTableViewCell:textEditDidBeginEditing:)]) {
            [self.delegate sheetTableViewCell:self textEditDidBeginEditing:field.text];
        }
    }
}

- (void) notifierDidEndEditing:(NSNotification *)notification {
    NVTextField* fieldNotification = (NVTextField*)notification.object;
    NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
    
    if (field == fieldNotification) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sheetTableViewCell:textEditDidEndEditing:)]) {
            [self.delegate sheetTableViewCell:self textEditDidEndEditing:field.text];
        }
    }
}


- (void) shakeTextEditAnimation {
    NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
    if (field) {
        [field shakeAnimation];
    }
}

- (void) becomeFirstResponder {
    NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
    if (field) {
        [field becomeFirstResponder];
    }
}

- (void) resignFirstResponder {
    NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
    if (field) {
        [field resignFirstResponder];
    }
}

- (void) setTextFieldValue:(id)text {
    NVTextField* field = (NVTextField*)[self.contentView viewWithTag:TAG_SHEET_CELL_FIELD];
    if (field) {
        if ([text isKindOfClass:[NSString class]]) {
            field.text = text;
        } else if ([text isKindOfClass:[NSAttributedString class]]) {
            field.attributedText = text;
        }
    }
}

- (void) updateDisplay {
    [self setObject:self.item];
}

- (void) buttonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sheetTableViewCell:didClickButton:)]) {
        [self.delegate sheetTableViewCell:self didClickButton:sender];
    }
}

- (void) rightButtonTouchUpInside:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sheetTableViewCell:didClickRightIconButton:)]) {
        [self.delegate sheetTableViewCell:self didClickRightIconButton:sender];
    }
}


+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}

+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return CELL_HEIGHT;
}

+ (NSString*) cellIdentifier {
    return CLS_SHEET_TABLE_VIEW_CELL;
}
@end



@implementation NVAttributeStringSheetTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        [self.lineLower removeFromSuperview];
        //        [self.lineUpper removeFromSuperview];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        _uiTitle.numberOfLines = 0;
        _uiTitle.frame = CGRectMake(20.0f, 5.0f, APPLICATIONWIDTH - 20.0f, CELL_HEIGHT - 10.0f);
    }
    
    return self;
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    NVSheetDataModel* dataModel = (NVSheetDataModel*)self.item;
    if ([dataModel.value isKindOfClass:[NSAttributedString class]]) {
        _uiTitle.attributedText = dataModel.value;
    }
    
    CGSize size = [dataModel.value boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 40.0f, 100000.0f)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                context:nil].size;
    CGRect frame = _uiTitle.frame;
    size.width = (size.width < APPLICATIONWIDTH - 40.0f) ? APPLICATIONWIDTH - 40.0f : size.width;
    frame.size = size;
    _uiTitle.frame = frame;
    
}

+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    
    NVSheetDataModel* dataModel = (NVSheetDataModel*)object;
    
    CGSize size = [dataModel.value boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 40.0f, 100000.0f)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                context:nil].size;
    
    return size.height + 20.0f;
}

+ (NSString*) cellIdentifier {
    return CLS_ATTRIBUTE_STRING_SHEET_TABLE_VIEW_CELL;
}

@end



@implementation NVSheetDataModel

- (id) init {
    self = [super init];
    if (self) {
        self.intro = YES;
        self.enable = YES;
    }
    
    return self;
}

@end



#import "NVGradientLayer.h"

@interface NVIntroSheetTableViewCell ()
@property (nonatomic, strong) NVGradientLayer* bgLayer;
@property (nonatomic, strong) NVLabel* uiValue;
@property (nonatomic, strong) UIImageView* introView;
@end


@implementation NVIntroSheetTableViewCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect frame = _uiTitle.frame;
        frame.origin.x = 15.0f;
        _uiTitle.frame = frame;
        
        UIImage* image = [UIImage imageNamed:@"icon_intro.png"];
        CGSize size = image.size;
        self.introView = [[UIImageView alloc] initWithImage:image];
        [self.contentView addSubview:self.introView];
        self.introView.frame = CGRectMake(APPLICATIONWIDTH - size.width - 10.0f * displayScale,
                                          (CELL_HEIGHT - size.height)/2,
                                          size.width,
                                          size.height);
        
        
        _uiValue        = [[NVLabel alloc] initWithFrame:CGRectMake(100.0f * displayScale,
                                                                    0.0f,
                                                                    APPLICATIONWIDTH - (100.0f + 20.0f) * displayScale,
                                                                    CELL_HEIGHT)];
        [self.contentView addSubview:_uiValue];
        _uiValue.font   = _uiTitle.font;
        _uiValue.numberOfLines   = 0;
        
        _bgLayer = [[NVGradientLayer alloc] init];
        _bgLayer.frame = CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH, CELL_HEIGHT);
        [self.layer insertSublayer:_bgLayer atIndex:0];
        
    }
    
    return self;
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    if (self.item.arrayBgColor != nil) {
        [_bgLayer removeColors];
        for (UIColor* color in self.item.arrayBgColor) {
            [_bgLayer addColor:color];
        }
        [_bgLayer setNeedsDisplay];
    }
    
    NVSheetDataModel* dataModel     = (NVSheetDataModel*)self.item;
    
    if (dataModel.valueFont) {
        _uiTitle.font                   = dataModel.valueFont;
        self.uiValue.font               = dataModel.valueFont;
    }
    if ([dataModel.value isKindOfClass:[NSString class]]) {
        self.uiValue.textColor          = dataModel.valueColor;
        self.uiValue.text               = dataModel.value;
        self.uiValue.textAlignment      = dataModel.valueAlignment;

    } else if ([dataModel.value isKindOfClass:[NSAttributedString class]]) {
        self.uiValue.attributedText     = dataModel.value;
    }
    
    
    
    self.introView.hidden           = !dataModel.intro;
}

@end



#define CELL_TEXT_VIEW_HEIGHT       120.0f

@implementation NVTextViewSheetTableViewCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        _uiTitle.hidden = YES;
        
        _uiTextView = [[NVPlaceHolderTextView alloc] initWithFrame:CGRectMake(20.0f, 10.0f, APPLICATIONWIDTH - 40.0f, CELL_TEXT_VIEW_HEIGHT - 20.0f)];
        [self.contentView addSubview:_uiTextView];
        [_uiTextView setFont:nvNormalFontWithSize(14.0f + fontScale)];
        _uiTextView.delegate = self;
    }
    
    return self;
}

- (void) setObject:(id)object {
    [super setObject:object];
    self.item.cellInstance = self;
    
    _uiTextView.placeHolder = self.item.placeHolder;
    self.delegate = self.item.delegate;
    
}

- (void) shakeTextEditAnimation {
    [_uiTextView shakeAnimation];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sheetTableViewCell:textEditDidChangeValue:)]) {
        [self.delegate sheetTableViewCell:self textEditDidChangeValue:textView.text];
    }
}

+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return CELL_TEXT_VIEW_HEIGHT;
}

+ (CGFloat) heightForCell {
    return CELL_TEXT_VIEW_HEIGHT;
}

@end




