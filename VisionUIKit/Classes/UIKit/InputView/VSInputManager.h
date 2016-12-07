//
//  VSInputManager.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/5.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>
#import "VSViewModel.h"

@interface VSInputViewModel : VSViewModel

PP_STRONG(UIColor,  fieldColor)
PP_STRONG(UIFont,   fieldFont)
PP_STRONG(NSString, fieldText)
PP_STRONG(NSString, placeHolderText)
PP_STRONG(UIColor,  placeHolderColor)
PP_ASSIGN_BASIC(int8_t, accuracy)

@property (nonatomic, assign) BOOL hideFinishedBTN;         //默认是隐藏的
@property (nonatomic, assign) UIKeyboardType keyboardType;  //默认

- (void)reset;

@end

typedef void(^VSInputFinished)(NSString *result, BOOL cancel);

@interface VSInputManager : NSObject

SINGLETON_ITF(VSInputManager)

PP_STRONG(VSInputViewModel, configModel);

- (void)inputText:(VSInputFinished) complation;
- (void)inputText:(NSString *)defaultText complation:(VSInputFinished) complation;
- (void)inputNumber:(NSString *)defaultText complation:(VSInputFinished) complation;
- (void)inputWeb:(NSString *)defaultText complation:(VSInputFinished)complation;
- (void)inputEmail:(NSString *)defaultText complation:(VSInputFinished)complation;


/**
 输入小数数值,默认精度没有限制

 @param defaultText 默认值
 @param complation  返回文本
 */
- (void)inputDecimal:(NSString *)defaultText
          complation:(VSInputFinished)complation;

/**
 精度位数控制

 @param defaultText <#defaultText description#>
 @param accuracy    默认保留2位小数
 @param complation  <#complation description#>
 */
- (void)inputDecimal:(NSString *)defaultText
            accuracy:(NSInteger)accuracy
          complation:(VSInputFinished)complation;


+ (void)InputText:(VSInputFinished) complation;
+ (void)InputText:(NSString *)defaultText complation:(VSInputFinished) complation;
+ (void)InputNumber:(NSString *)defaultText complation:(VSInputFinished) complation;
+ (void)InputWeb:(NSString *)defaultText complation:(VSInputFinished)complation;
+ (void)InputEmail:(NSString *)defaultText complation:(VSInputFinished)complation;
+ (void)InputDecimal:(NSString *)defaultText
          complation:(VSInputFinished)complation;
+ (void)InputDecimal:(NSString *)defaultText
            accuracy:(NSInteger)accuracy
          complation:(VSInputFinished)complation;

@end
