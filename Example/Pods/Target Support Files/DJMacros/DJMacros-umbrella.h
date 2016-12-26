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

#import "DJMacro.h"
#import "NSAttributedString+DJCategory.h"
#import "NSMutableAttributedString+DJCategory.h"
#import "TTTAttributedLabel+DJCategory.h"
#import "UIColor+HEX.h"

FOUNDATION_EXPORT double DJMacrosVersionNumber;
FOUNDATION_EXPORT const unsigned char DJMacrosVersionString[];

