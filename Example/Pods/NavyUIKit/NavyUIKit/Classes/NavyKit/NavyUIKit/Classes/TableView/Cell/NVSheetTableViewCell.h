//
//  NVSheetTableViewCell.h
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewLineCell.h"
#import "NVLabel.h"
#import "NVPlaceHolderTextView.h"

@class NVSheetDataModel;

typedef NS_ENUM(NSUInteger, NVSheetTableViewCellStyle) {
    NVSheetTableViewCellStyleDefault,       //只有标题
    NVSheetTableViewCellStyleEdit,          //左边标题 右边输入框
    NVSheetTableViewCellStyleEdit2,         //输入框 和 placeholder
    NVSheetTableViewCellStyleEdit3,         //左边标题 右边输入框 最右边按钮
    NVSheetTableViewCellStyleTitle,         //标题居中
    NVSheetTableViewCellStyleEditButton,    //按钮功能
};



#define CLS_SHEET_TABLE_VIEW_CELL       @"NVSheetTableViewCell"

@protocol NVSheetTableViewCellDelegate;

@interface NVSheetTableViewCell : NVTableViewLineCell {
    UIImageView* _uiBgView;
    NVLabel* _uiTitle;
    NSInteger _maxLength; //最大的输入长度
}
@property (nonatomic, strong) NVSheetDataModel* item;
@property (nonatomic, assign) id<NVSheetTableViewCellDelegate> delegate;
- (void) shakeTextEditAnimation;
- (void) becomeFirstResponder;
- (void) resignFirstResponder;
- (void) setTextFieldValue:(id)text;
- (void) updateDisplay;
@end

@protocol NVSheetTableViewCellDelegate <NSObject>

@optional
- (void) sheetTableViewCell:(NVSheetTableViewCell*)cell didClickButton:(id)object;
- (void) sheetTableViewCell:(NVSheetTableViewCell *)cell textEditDidChangeValue:(NSString*)value;
- (void) sheetTableViewCell:(NVSheetTableViewCell *)cell textEditDidBeginEditing:(NSString*)value;
- (void) sheetTableViewCell:(NVSheetTableViewCell *)cell textEditDidEndEditing:(NSString *)value;
- (void) sheetTableViewCell:(NVSheetTableViewCell *)cell didClickRightIconButton:(id)object;
@end



@interface NVSheetDataModel : NVDataModel
@property (nonatomic, assign) NVSheetTableViewCellStyle cellStyle;
@property (nonatomic, strong) id title;
@property (nonatomic, strong) UIColor* titleColor;

@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, strong) NSString* placeHolder;
@property (nonatomic, strong) UIColor* placeHolderColor;

@property (nonatomic, strong) id value;
@property (nonatomic, strong) UIColor* valueColor;
@property (nonatomic, assign) NSTextAlignment valueAlignment;
@property (nonatomic, strong) UIFont* valueFont;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) BOOL intro;
@property (nonatomic, strong) NSArray* arrayBgColor;

@property (nonatomic, assign) BOOL enable;

@property (nonatomic, strong) UIImage* rightButtonIconImage;
@end



#define CLS_ATTRIBUTE_STRING_SHEET_TABLE_VIEW_CELL      @"NVAttributeStringSheetTableViewCell"

@interface NVAttributeStringSheetTableViewCell : NVSheetTableViewCell

@end



#define CLS_INTRO_SHEET_TABLE_VIEW_CELL         @"NVIntroSheetTableViewCell"

@interface NVIntroSheetTableViewCell : NVSheetTableViewCell

@end



#define CLS_TEXT_VIEW_SHEET_TABLE_VIEW_CELL     @"NVTextViewSheetTableViewCell"

@interface NVTextViewSheetTableViewCell : NVSheetTableViewCell
<UITextViewDelegate>
@property (nonatomic, strong, readonly) NVPlaceHolderTextView* uiTextView;
@end


