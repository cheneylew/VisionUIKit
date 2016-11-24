//
//  NVTextField.h
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NVTextFieldDelegate <NSObject>

@optional
//点击完成button会响应的方法
- (void)doneButtonDidPressedDelegate:(id)sender;

@end


@interface NVTextField : UITextField
@property (nonatomic, strong) UIColor* placeHolderColor;
@property (nonatomic, assign) NSInteger formId;

@property (nonatomic, weak) id<NVTextFieldDelegate> doneDelegate;

@end
