//
//  VSInputManager.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/5.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSInputManager.h"
#import "VSTextField.h"
#import <KKCategories/KKCategories.h>

@implementation VSInputViewModel

- (void)initModel {
    [super initModel];
    [self setDefault];
}

- (void)setDefault {
    self.fieldFont = [UIFont systemFontOfSize:FIT6P(48)];
    self.fieldColor = [UIColor blackColor];
    self.fieldText = @"";
    self.placeHolderText = @"";
    self.placeHolderColor = [UIColor lightGrayColor];
    self.keyboardType = UIKeyboardTypeDefault;
    self.hideFinishedBTN = NO;
    self.accuracy = 2;
}

- (void)reset {
    [self setDefault];
}

@end

@interface VSInputManager()
<UITextFieldDelegate>

@property (nonatomic, copy) VSInputFinished finished;
PP_STRONG(VSTextField, textField)
PP_STRONG(UIView, inputView)
PP_STRONG(UIView, backgroundView)
PP_STRONG(UIButton, finishedButton)
PP_BOOL(isEnable)

@end

@implementation VSInputManager

SINGLETON_IMPL(VSInputManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configModel = [VSInputViewModel new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

+ (void)InputText:(VSInputFinished)complation {
    [[VSInputManager sharedInstance] inputText:complation];
}

+ (void)InputText:(NSString *)defaultText complation:(VSInputFinished)complation {
    [[VSInputManager sharedInstance] inputText:defaultText complation:complation];
}

+ (void)InputNumber:(NSString *)defaultText complation:(VSInputFinished)complation {
    [[VSInputManager sharedInstance] inputNumber:defaultText complation:complation];
}

+ (void)InputWeb:(NSString *)defaultText complation:(VSInputFinished)complation {
    [[VSInputManager sharedInstance] inputWeb:defaultText complation:complation];
}

+ (void)InputEmail:(NSString *)defaultText complation:(VSInputFinished)complation {
    [[VSInputManager sharedInstance] inputEmail:defaultText complation:complation];
}

+ (void)InputDecimal:(NSString *)defaultText complation:(VSInputFinished)complation {
    [[VSInputManager sharedInstance] inputDecimal:defaultText complation:complation];
}

+ (void)InputDecimal:(NSString *)defaultText accuracy:(NSInteger)accuracy complation:(VSInputFinished)complation {
    [[VSInputManager sharedInstance] inputDecimal:defaultText accuracy:accuracy complation:complation];
}

- (void)inputText:(VSInputFinished) complation {
    [self inputText:@"" complation:complation];
}

- (void)inputText:(NSString *)defaultText complation:(VSInputFinished)complation {
    self.isEnable = YES;
    self.configModel.fieldText = defaultText;
    self.finished = complation;
    [self showInputView];
}

- (void)inputNumber:(NSString *)defaultText complation:(VSInputFinished)complation {
    self.configModel.keyboardType = UIKeyboardTypeNumberPad;
    [self inputText:defaultText complation:complation];
}

- (void)inputDecimal:(NSString *)defaultText complation:(VSInputFinished)complation {
    [self inputDecimal:defaultText accuracy:INT_MAX complation:complation];
}

- (void)inputDecimal:(NSString *)defaultText
            accuracy:(NSInteger)accuracy
          complation:(VSInputFinished)complation {
    self.configModel.accuracy     = accuracy;
    self.configModel.keyboardType = UIKeyboardTypeDecimalPad;
    [self inputText:defaultText complation:complation];
}

- (void)inputWeb:(NSString *)defaultText complation:(VSInputFinished)complation {
    self.configModel.keyboardType = UIKeyboardTypeWebSearch;
    [self inputText:defaultText complation:complation];
}

- (void)inputEmail:(NSString *)defaultText complation:(VSInputFinished)complation {
    self.configModel.keyboardType = UIKeyboardTypeEmailAddress;
    [self inputText:defaultText complation:complation];
}

- (VSTextField *)textField {
    if (_textField == nil) {
        _textField = [[VSTextField alloc] initWithFrame:CGRectMake(FIT6P(26),
                                                                   FIT6P(22),
                                                                   SCREEN_WIDTH - FIT6P(26) * 2,
                                                                   FIT6P(105))];
        _textField.layer.cornerRadius = 4.0f;
        _textField.layer.borderColor = HEX(0xdddddd).CGColor;
        _textField.layer.borderWidth = 1.0f;
        _textField.backgroundColor = HEX(0xfcfcfc);
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:FIT6P(48)];
        _textField.textColor = [UIColor blackColor];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.inputAccessoryView = nil;
//        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
//        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    
    return _textField;
}

- (UIView *)inputView {
    if (_inputView == nil) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              SCREEN_WIDTH,
                                                              FIT6P(150))];
        _inputView.backgroundColor = HEX(0xf2f2f4);
        _inputView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_inputView addTopBorderWithHeight:0.5 andColor:HEX(0xabb3bc)];
        [_inputView addSubview:self.textField];
        
        [_inputView addSubview:self.finishedButton];
        
        self.textField.width = _inputView.width - FIT6P(200);
        self.finishedButton.right = _inputView.width - FIT6P(10);
        self.finishedButton.centerY = _inputView.height/2.0f;
    }
    
    return _inputView;
}

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT)];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.layer.opacity = .6;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        WEAK_SELF;
        [_backgroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself show:NO];
             BLOCK_SAFE_RUN(weakself.finished, weakself.textField.text, YES);
        }];
    }
    
    return _backgroundView;
}

- (UIButton *)finishedButton {
    if (_finishedButton == nil) {
        WEAK_SELF;
        _finishedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishedButton.frame = CGRectMake(0, 0, FIT6P(160), FIT6P(105));
        _finishedButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_finishedButton setTitleColor:HEX(0xa1a4a9) forState:UIControlStateNormal];
        [_finishedButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishedButton jk_addActionHandler:^(NSInteger tag) {
            BLOCK_SAFE_RUN(weakself.finished,weakself.textField.text, NO);
            [weakself show:NO];
        }];
    }
    
    return _finishedButton;
}

- (void)show:(BOOL) isShow {
    WEAK_SELF;
    if (isShow) {
        UIWindow *window = [[UIApplication sharedApplication].delegate performSelector:@selector(window)];
        
        [window addSubview:self.backgroundView];
        self.backgroundView.layer.opacity = 0;
        [UIView animateWithDuration:0.25 animations:^{
            weakself.backgroundView.layer.opacity = 0.2;
        }];
        
        self.inputView.top = window.height;
        [window addSubview:self.inputView];
        
        self.textField.text = self.configModel.fieldText;
        self.textField.font = self.configModel.fieldFont;
        self.textField.textColor = self.configModel.fieldColor;
        self.textField.placeholder = self.configModel.placeHolderText;
        self.textField.vs_placeholderColor = self.configModel.placeHolderColor;
        self.textField.keyboardType = self.configModel.keyboardType;
        [self.textField becomeFirstResponder];
        
        if (self.configModel.hideFinishedBTN) {
            self.finishedButton.hidden = YES;
            self.textField.width = SCREEN_WIDTH - FIT6P(26) * 2;
        } else {
            self.finishedButton.hidden = NO;
            self.textField.width = _inputView.width - FIT6P(200);
        }
        
    }else {
        self.isEnable = NO;
        [self.textField resignFirstResponder];
        [UIView animateWithDuration:0.2 animations:^{
            weakself.inputView.top = SCREEN_HEIGHT;
            weakself.backgroundView.layer.opacity = 0;
        } completion:^(BOOL finished) {
            [weakself.inputView removeFromSuperview];
            [weakself.backgroundView removeFromSuperview];
        }];
    }
}

- (void)showInputView {
    [self show:YES];
}

#pragma mark keyboard process

- (void)systemKeyboardWillShow:(NSNotification *) notify {
    if (!self.isEnable) {
        return;
    }
    NSDictionary *userInfo = notify.userInfo;
    if (userInfo) {
        NSValue *keyBoardFrame = [userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
        CGRect frame = keyBoardFrame.CGRectValue;
        WEAK_SELF;
        [UIView animateWithDuration:0.25 animations:^{
           weakself.inputView.bottom = frame.origin.y;
        }];
    }
}

#pragma mark textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BLOCK_SAFE_RUN(self.finished,self.textField.text, NO);
    [self show:NO];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.configModel.keyboardType == UIKeyboardTypeDecimalPad) {
        if (string.length == 0) {
            return YES;
        }
        NSString *text = textField.text;
        NSArray *arr = [text componentsSeparatedByString:@"."];
        if (arr.count >= 2) {
            NSString *decimalString = arr.lastObject;
            if (decimalString.length == self.configModel.accuracy) {
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark 配置样式
- (void)setConfigModel:(VSInputViewModel *)configModel {
    if (configModel != _configModel) {
        _configModel = configModel;
    }
}

@end
