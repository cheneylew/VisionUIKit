#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KKCategories.h"
#import "NSArray+JKSafeAccess.h"
#import "NSData+JKBase64.h"
#import "NSData+JKEncrypt.h"
#import "NSDate+JKUtilities.h"
#import "NSDictionary+JKJSONString.h"
#import "NSDictionary+JKSafeAccess.h"
#import "NSObject+JKBlocks.h"
#import "NSObject+JKRuntime.h"
#import "NSString+JKBase64.h"
#import "NSString+JKContains.h"
#import "NSString+JKDictionaryValue.h"
#import "NSString+JKEmoji.h"
#import "NSString+JKEncrypt.h"
#import "NSString+JKHash.h"
#import "NSString+JKMatcher.h"
#import "NSString+JKMIME.h"
#import "NSString+JKNormalRegex.h"
#import "NSString+JKPinyin.h"
#import "NSString+JKRemoveEmoji.h"
#import "NSString+JKScore.h"
#import "NSString+JKSize.h"
#import "NSString+JKTrims.h"
#import "NSString+JKURLEncode.h"
#import "NSString+JKUUID.h"
#import "NSString+JKXMLDictionary.h"
#import "UIAlertView+JKBlock.h"
#import "UIButton+JKBlock.h"
#import "UIButton+JKImagePosition.h"
#import "UIColor+JKCategory.h"
#import "UIColor+JKGradient.h"
#import "UIColor+JKHEX.h"
#import "UIControl+JKActionBlocks.h"
#import "UIControl+JKBlock.h"
#import "UIImage+JKCategory.h"
#import "UIImage+JKColor.h"
#import "UIImage+JKOrientation.h"
#import "UIImage+LXExtension.h"
#import "UITextField+JKBlocks.h"
#import "UITextField+JKSelect.h"
#import "UITextField+JKShake.h"
#import "UIView+Borders.h"
#import "UIView+Debug.h"
#import "UIView+JKBlockGesture.h"
#import "UIView+JKCustomBorder.h"
#import "UIView+JKFind.h"
#import "UIView+JKShake.h"
#import "UIView+JKVisuals.h"
#import "UIView+Nib.h"
#import "UIView+Screenshot.h"
#import "UIView+Utils.h"
#import "UIViewController+JKBackButtonTouched.h"

FOUNDATION_EXPORT double KKCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char KKCategoriesVersionString[];

