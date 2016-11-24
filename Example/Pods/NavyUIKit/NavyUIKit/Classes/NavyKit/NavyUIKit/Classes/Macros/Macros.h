//
//  NavyUIKit.h
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __OBJC__

#define IOS8_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

/*!
 常用字体Macro
 */
#define FONT_HEITI_LIGHT_SIZE(s)            [UIFont fontWithName:@"STHeitiSC-Light" size:s]
#define FONT_HEITI_LIGHT                    FONT_HEITI_LIGHT_SIZE(14.0f)
#define FONT_HEITI_SIZE(s)                  [UIFont fontWithName:@"STHeitiSC" size:s]
#define FONT_HEITI                          FONT_HEITI_SIZE(14.0f)
#define FONT_HEITI_MEDIUM_SIZE(s)           [UIFont fontWithName:@"STHeitiSC-MEDIUM" size:s]
#define FONT_HEITI_MEDIUM                   FONT_HEITI_MEDIUM_SIZE(14.0f)

#define FONT_HELVETICA_SIZE(s)              [UIFont fontWithName:@"Helvetica" size:s]
#define FONT_HELVETICA_BOLD_SIZE(s)         [UIFont fontWithName:@"Helvetica-Bold" size:s]

#define FONT_HELVETICA_NEUE_SIZE(s)                         [UIFont fontWithName:@"HelveticaNeue" size:s]
#define FONT_HELVETICA_NEUE_BOLD_SIZE(s)                    [UIFont fontWithName:@"HelveticaNeue-Bold" size:s]
#define FONT_HELVETICA_NEUE_LIGHT_SIZE(s)                   [UIFont fontWithName:@"HelveticaNeue-Light" size:s]
#define FONT_HELVETICA_NEUE_ULTRA_LIGHT_SIZE(s)             [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:s]

#define FONT_APPLE_GOTHIC_NEO_THIN_SIZE(s)                  [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:s]
#define FONT_BANK_CARD_NUMBER_SIZE(s)                       [UIFont fontWithName:@"Farrington-7B-Qiqi" size:s]

#define FONT_LANTING_SIZE(s)                        [UIFont fontWithName:@"Lantinghei SC" size:s]

#define FONT_PINGFANG_SIZE(s)                       [UIFont fontWithName:@"PingFang SC" size:s]
#define FONT_PINGFANG_LIGHT_SIZE(s)                 [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define FONT_PINGFANG_THIN_SIZE(s)                  [UIFont fontWithName:@"PingFangSC-Thin" size:s]
#define FONT_PINGFANG_ULTRA_LIGHT_SIZE(s)           [UIFont fontWithName:@"PingFangSC-Ultralight" size:s]

#define FONT_AVENIR_LIGHT_SIZE(s)                   [UIFont fontWithName:@"Avenir-Light" size:s]


#define FONT_SYSTEM_SIZE(s)                 [UIFont systemFontOfSize:s]
#define FONT_BOLD_SYSTEM_SIZE(s)            [UIFont boldSystemFontOfSize:s]


/*!
 常用颜色Macro
 */
#define COLOR_HM_BLACK                      [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]
#define COLOR_HM_LIGHT_BLACK                [UIColor colorWithRed:87.0f/255.0f green:87.0f/255.0f blue:87.0f/255.0f alpha:1.0f]
#define COLOR_HM_DARK_GRAY                  [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]
#define COLOR_HM_GRAY                       [UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
#define COLOR_HM_LIGHT_GRAY                 [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f]
#define COLOR_HM_WHITE_GRAY                 [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]

#define COLOR_HM_ORANGE                     [UIColor colorWithRed:255.0f/255.0f green:102.0f/255.0f blue:51.0f/255.0f alpha:1.0f]
#define COLOR_HM_DRAK_ORANGE                [UIColor colorWithRed:255.0f/255.0f green:86.0f/255.0f blue:30.0f/255.0f alpha:1.0f]
#define COLOR_HM_LIGHT_ORANGE               [UIColor colorWithRed:232.0f/255.0f green:136.0f/255.0f blue:63.0f/255.0f alpha:0.8f]
#define COLOR_HM_BLUE                       [UIColor colorWithRed:77.0f/255.0f green:157.0f/255.0f blue:215.0f/255.0f alpha:1.0f]

#define COLOR_LINE                          COLOR_HM_LIGHT_GRAY
#define COLOR_DEFAULT_WHITE                 [UIColor whiteColor]
#define COLOR_DEFAULT_BLACK                 [UIColor blackColor]
#define COLOR_SKY_BLUE                      [UIColor colorWithRed:76.0f/255.0f green:172.0f/255.0f blue:239.0f/255.0f alpha:0.8f]
#define COLOR_SKY_GRAY                      [UIColor colorWithRed:180.0f/255.0f green:180.0f/255.0f blue:180.0f/255.0f alpha:0.8f]


#define ATTR_DICTIONARY(color, size)                    @{NSForegroundColorAttributeName : color, NSFontAttributeName : nvNormalFontWithSize(size)}
#define ATTR_DICTIONARY2(color, bg_color, size)         @{NSForegroundColorAttributeName : color, NSBackgroundColorAttributeName: bg_color, NSFontAttributeName : nvNormalFontWithSize(size)}
#define ATTR_DICTIONARY3(color, font)                   @{NSForegroundColorAttributeName : color, NSFontAttributeName : font}


#define ATTRSTRING(text, attribute)         [[NSMutableAttributedString alloc] initWithString:text attributes:attribute]
#define ATTRSTRING2(attributedString)       [[NSMutableAttributedString alloc] initWithAttributedString:attributedString]

#define APPLICATIONWIDTH                    [UIScreen mainScreen].applicationFrame.size.width
#define APPLICATIONHEIGHT                   [UIScreen mainScreen].applicationFrame.size.height
#define APPLICATIONFRAME                    [UIScreen mainScreen].applicationFrame
#define APPLICATIONBOUNDS                   [UIScreen mainScreen].bounds
#define SCREENHEIGHT                        [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH                         [UIScreen mainScreen].bounds.size.width
#define NAVIGATIONBARBOUNDS                 (self.navigationController.navigationBar.bounds)
#define NAVIGATIONBARHEIGHT                 (NAVIGATIONBARBOUNDS.size.height)
#define TABBARHEIGHT                        (49.0f)
#define BASE_CELL_HEIGHT                    (38.0f * displayScale)



#define nvBoldFontWithSize(size)            FONT_BOLD_SYSTEM_SIZE(size)
#define nvNormalFontWithSize(size)          FONT_SYSTEM_SIZE(size)
#define nvNumberFontWithSize(size)          FONT_LANTING_SIZE(size)




UIFont* navigationTitleFont();
UIFont* navigationTitleFontWithSize(CGFloat size);



#define displayScale    (nativeScale() / 2)
#define fontScale       ((ceil(displayScale)-1)*2)

CGFloat nativeScale(void);

/*!
 屏幕等比缩放适配
 */
#define fit5(x) ((x)/640.0f)*APPLICATIONWIDTH
#define fit6(x) ((x)/750.0f)*APPLICATIONWIDTH
#define fit6p(x) ((x)/1242.0f)*APPLICATIONWIDTH
#define fit1024(x) ((x)/1024.0f)*APPLICATIONWIDTH
#define fitRect6(x,y,w,h) CGRectMake(fit6(x), fit6(y), fit6(w), fit6(h))
#define fitRect1024(x,y,w,h) CGRectMake(fit1024(x), fit1024(y), fit1024(w), fit1024(h))

/*!
 DEBUG模式输出Log
 */
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#endif
