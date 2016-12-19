//
//  VSTextField.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSTextField;
@protocol VSTextFieldDelegate <NSObject>

@optional
- (void)textFieldDidPressedDone:(VSTextField *)textField;

@end

@interface VSTextField : UITextField

@property (nonatomic, strong) UIColor *vs_placeholderColor;
@property (nonatomic, strong) UIFont *vs_placeholderFont;

@property (nonatomic, weak) id<VSTextFieldDelegate> doneDelegate;

@end
