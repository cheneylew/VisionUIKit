//
//  DJMacro.h
//  DJMacros
//
//  Created by Dejun Liu on 2016/11/11.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//  宏定义规范：所有字母大写，单词之间通过下划线区分
//

#import     <Foundation/Foundation.h>
#import     <mach/mach_time.h>
#import     <CoreGraphics/CGBase.h>
#include    <Availability.h>            //苹果版本

#ifdef __OBJC__

CGSize  ScreenSize();

#define SCREEN_SIZE             ScreenSize()
#define SCREEN_WIDTH            SCREEN_SIZE.width
#define SCREEN_HEIGHT           SCREEN_SIZE.height
#define STATUS_BAR_FRAME        [UIApplication sharedApplication].statusBarFrame

#define CURRENT_LAUGUAGE        ([[NSLocale preferredLanguages] objectAtIndex:0])

#define RGB(r,g,b)              [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a)           [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HEXA(hex,a)             [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
                                green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]
#define HEX(hex)                HEXA(hex,1)

#define FIT5(x)                 ((x)/640.0f)*SCREEN_WIDTH
#define FIT6(x)                 ((x)/750.0f)*SCREEN_WIDTH
#define FIT6P(x)                ((x)/1242.0f)*SCREEN_WIDTH
#define FIT1024(x)              ((x)/1024.0f)*SCREEN_WIDTH
#define FIT_RECT6(x,y,w,h)      CGRectMake(FIT6(x), FIT6(y), FIT6(w), FIT6(h))
#define FIT_RECT1024(x,y,w,h)   CGRectMake(FIT1024(x), FIT1024(y), FIT1024(w), FIT1024(h))

#define LOAD_NIB_NAMED(nibName) do{[MAIN_BUNDLE loadNibNamed:nibName owner:self options:nil];}while(0)

#define DEVICE_IS_PAD           ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define DEVICE_IS_PHONE         ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define DEVICE_ORIENTATION      [[UIApplication sharedApplication] statusBarOrientation]
#define DEVICE_IS_PORTRAIT      (DEVICE_ORIENTATION == UIInterfaceOrientationPortrait || \
                                DEVICE_ORIENTATION == UIInterfaceOrientationPortraitUpsideDown)
#define DEVICE_IS_LANDSCAPE            (DEVICE_ORIENTATION == UIInterfaceOrientationLandscapeLeft || \
                                DEVICE_ORIENTATION == UIInterfaceOrientationLandscapeRight)

#define NOTIFICATION_CENTER                         [NSNotificationCenter defaultCenter]
#define FILE_MANAGER                                [NSFileManager defaultManager]
#define MAIN_BUNDLE                                 [NSBundle mainBundle]
#define MAIN_THREAD                                 [NSThread mainThread]
#define MAIN_SCREEN                                 [UIScreen mainScreen]
#define USER_DEFAULTS                               [NSUserDefaults standardUserDefaults]
#define APPLICATION                                 [UIApplication sharedApplication]
#define CURRENT_DEVICE                              [UIDevice currentDevice]
#define MAIN_RUN_LOOP                               [NSRunLoop mainRunLoop]
#define GENERAL_PASTEBOARD                          [UIPasteboard generalPasteboard]

#define APP_VERSION             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_NAME                [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_BUNDLE_ID           [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleIdentifier"]

#define SINGLETON_ITF(class)    \
                                + (class*)sharedInstance;
#define SINGLETON_IMPL(class)   \
                                static class* gInstance = nil; \
                                + (class*)sharedInstance { \
                                if (!gInstance) { \
                                @synchronized(self) { \
                                if (!gInstance) gInstance = [[self alloc] init]; \
                                } \
                                } \
                                return gInstance; \
                                }

#define SINGLETON_AUTOLOAD(class) \
                                SINGLETON_ITF(class) \
                                + (void)load \
                                { \
                                [class sharedInstance]; \
                                }

#pragma mark -
#pragma mark iOS Version

#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IOS_VERSION_COMPARE_GREATER_THAN(a,b)    ([a compare:b options:NSNumericSearch] == NSOrderedDescending)

#define IOS9_OR_LATER          ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS8_OR_LATER          ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER          ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER          ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER          ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER          ( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER          ( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define iPhone4                 ([[UIScreen mainScreen] bounds].size.height == 480.0)
#define iPhone5                 ([[UIScreen mainScreen] bounds].size.height == 568.0)
#define iPhone5OrSmaller        ([[UIScreen mainScreen] bounds].size.height <= 568.0)
#define iPhone5OrBigger         ([[UIScreen mainScreen] bounds].size.height >= 568.0)
#define iPhone6                 ([[UIScreen mainScreen] bounds].size.height == 667.0)
#define iPhone6OrSmaller        ([[UIScreen mainScreen] bounds].size.height <= 667.0)
#define iPhone6OrBigger         ([[UIScreen mainScreen] bounds].size.height >= 667.0)
#define iPhone6Plus             ([[UIScreen mainScreen] bounds].size.height == 736.0)
#define iPhone6PlusOrSmaller    ([[UIScreen mainScreen] bounds].size.height <= 736.0)

#pragma mark -
#pragma mark Collections

#define IDARRAY(...)           (id []){ __VA_ARGS__ }
#define IDCOUNT(...)           (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))

#define ARRAY(...)             [NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)]

#define DICT(...)              DictionaryWithIDArray(IDARRAY(__VA_ARGS__), IDCOUNT(__VA_ARGS__) / 2)

#define POINTERIZE(x)          ((__typeof__(x) []){ x })
#define NSVALUE(x)             [NSValue valueWithBytes: POINTERIZE(x) objCType: @encode(__typeof__(x))]

#pragma mark -
#pragma mark Blocks

#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil

#pragma mark -
#pragma mark Logging

#ifdef DEBUG
#define DLog(fmt, ...)          NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLogFrame(f)            DLog(@"x:%f y:%f w:%f h:%f", f.origin.x, f.origin.y, f.size.width, f.size.height)
#define DLogPoint(p)            DLog(@"x:%f y:%f", p.x, p.y)
#define DLogSize(s)             DLog(@"w:%f h:%f", s.width, s.height)
#define DLogFloat(f)            DLog(@"%f", f)
#else
#define DLog(...)
#endif

#define kMETHOD_NOT_IMPLEMENTED()       NSAssert(NO, @"You must override %@ in a subclass", NSStringFromSelector(_cmd))

#pragma mark -
#pragma mark NSNumber

#define NUM_INT(int)           [NSNumber numberWithInt:int]
#define NUM_FLOAT(float)       [NSNumber numberWithFloat:float]
#define NUM_BOOL(bool)         [NSNumber numberWithBool:bool]

#pragma mark -
#pragma mark Frame Geometry

#define CENTER_VERTICALLY(parent,child)                floor((parent.frame.size.height - child.frame.size.height) / 2)
#define CENTER_HORIZONTALLY(parent,child)              floor((parent.frame.size.width - child.frame.size.width) / 2)

#define CENTER_IN_PARENT(parent,childWidth,childHeight) CGPointMake(floor((parent.frame.size.width - childWidth) / 2),floor((parent.frame.size.height - childHeight) / 2))
#define CENTER_IN_PARENT_X(parent,childWidth)          floor((parent.frame.size.width - childWidth) / 2)
#define CENTER_IN_PARENT_Y(parent,childHeight)         floor((parent.frame.size.height - childHeight) / 2)

#define WIDTH(view)            view.frame.size.width
#define HEIGHT(view)           view.frame.size.height
#define X(view)                view.frame.origin.x
#define Y(view)                view.frame.origin.y
#define LEFT(view)             view.frame.origin.x
#define TOP(view)              view.frame.origin.y
#define BOTTOM(view)           (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view)            (view.frame.origin.x + view.frame.size.width)

// Update current frame
#define UPDATE_FRAME_X(newX)						do{CGRect __tmpFrame = self.frame; __tmpFrame.origin.x = (newX); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_Y(newY)						do{CGRect __tmpFrame = self.frame; __tmpFrame.origin.y = (newY); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_WIDTH(newWidth)				do{CGRect __tmpFrame = self.frame; __tmpFrame.size.width = (newWidth); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_HEIGHT(newHeight)				do{CGRect __tmpFrame = self.frame; __tmpFrame.size.height = (newHeight); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_SIZE(newSize)                  do{CGRect __tmpFrame = self.frame; __tmpFrame.size = (newSize); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_ORIGIN(newOrigin)				do{CGRect __tmpFrame = self.frame; __tmpFrame.origin = (newOrigin); self.frame = __tmpFrame;}while(0)

// Update a view frame
#define UPDATE_VIEW_FRAME_X(aView, newX)			do{CGRect __tmpFrame = aView.frame; __tmpFrame.origin.x = (newX); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_Y(aView, newY)			do{CGRect __tmpFrame = aView.frame; __tmpFrame.origin.y = (newY); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_WIDTH(aView, newWidth)	do{CGRect __tmpFrame = aView.frame; __tmpFrame.size.width = (newWidth); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_HEIGHT(aView, newHeight)	do{CGRect __tmpFrame = aView.frame; __tmpFrame.size.height = (newHeight); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_SIZE(aView,newSize)       do{CGRect __tmpFrame = aView.frame; __tmpFrame.size = (newSize); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_ORIGIN(aView,newOrigin)   do{CGRect __tmpFrame = aView.frame; __tmpFrame.origin = (newOrigin); aView.frame = __tmpFrame;}while(0)

// Update current bounds
#define UPDATE_BOUNDS_X(newX)						do{CGRect __tmpBounds = self.bounds; __tmpBounds.origin.x = (newX); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_Y(newY)						do{CGRect __tmpBounds = self.bounds; __tmpBounds.origin.y = (newY); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_WIDTH(newWidth)				do{CGRect __tmpBounds = self.bounds; __tmpBounds.size.width = (newWidth); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_HEIGHT(newHeight)				do{CGRect __tmpBounds = self.bounds; __tmpBounds.size.height = (newHeight); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_SIZE(newSize)                 do{CGRect __tmpBounds = self.bounds; __tmpBounds.size = (newSize); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_ORIGIN(newOrigin)				do{CGRect __tmpBounds = self.bounds; __tmpBounds.origin = (newOrigin); self.bounds = __tmpBounds;}while(0)

// Update a view bounds
#define UPDATE_VIEW_BOUNDS_X(aView, newX)			do{CGRect __tmpBounds = aView.bounds; __tmpBounds.origin.x = (newX); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_Y(aView, newY)			do{CGRect __tmpBounds = aView.bounds; __tmpBounds.origin.y = (newY); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_WIDTH(aView, newWidth)	do{CGRect __tmpBounds = aView.bounds; __tmpBounds.size.width = (newWidth); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_HEIGHT(aView, newHeight)	do{CGRect __tmpBounds = aView.bounds; __tmpBounds.size.height = (newHeight); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_SIZE(aView,newSize)      do{CGRect __tmpBounds = aView.bounds; __tmpBounds.size = (newSize); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_ORIGIN(aView,newOrigin)  do{CGRect __tmpBounds = aView.bounds; __tmpBounds.origin = (newOrigin); aView.bounds = __tmpBounds;}while(0)

// Update current center
#define UPDATE_CENTER_X(newX)						do{CGPoint __tmpCenter = self.center; __tmpCenter.x = (newX); self.center = __tmpCenter;}while(0)
#define UPDATE_CENTER_Y(newY)						do{CGPoint __tmpCenter = self.center; __tmpCenter.y = (newY); self.center = __tmpCenter;}while(0)

// Update a view center
#define UPDATE_VIEW_CENTER_X(aView, newX)			do{CGPoint __tmpCenter = aView.center; __tmpCenter.x = (newX); aView.center = __tmpCenter;}while(0)
#define UPDATE_VIEW_CENTER_Y(aView, newY)			do{CGPoint __tmpCenter = aView.center; __tmpCenter.y = (newY); aView.center = __tmpCenter;}while(0)

// Autoresizing mask
#define UIViewAutoresizingTopAlign                  (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth)
#define UIViewAutoresizingBottomAlign               (UIViewAutoresizingFlexibleTopMargin    | UIViewAutoresizingFlexibleWidth)
#define UIViewAutoresizingCentered                  (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin)
#define UIViewAutoresizingFill                      (UIViewAutoresizingFlexibleHeight       | UIViewAutoresizingFlexibleWidth)

// Default components size
#define STATUS_BAR_DEFAULT_HEIGHT                   20
#define NAVIGATION_BAR_DEFAULT_HEIGHT               44
#define TOOLBAR_DEFAULT_HEIGHT                      44
#define TABBAR_DEFAULT_HEIGHT                       56

#pragma mark -
#pragma mark IndexPath

#define INDEX_PATH(a,b)        [NSIndexPath indexPathWithIndexes:(NSUInteger[]){a,b} length:2]

#pragma mark -
#pragma mark Transforms

#define DEG_TO_RAD(degrees) ((degrees) * M_PI / 180.0)
#define RAD_TO_DEG(radians) ((radians) * 180.0 / M_PI)

#pragma mark -
#pragma mark 线程操作
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#pragma mark -
#pragma mark 变量声明

#define DECLARE_KEY( key )                      FOUNDATION_EXPORT NSString *const key;
#define DEFINE_KEY( key )                       NSString *const key = @ #key;
#define DEFINE_KEY_WITH_VALUE( key, property )  NSString *const key = @ #property;

#pragma mark -
#pragma mark Weak Strong Object

#define WEAK_WITH_NAME_OBJECT(_obj, _name)      __weak typeof(_obj) weak##_name = _obj
#define WEAK(_obj)                              WEAK_WITH_NAME_OBJECT(_obj, _obj)
#define WEAK_SELF                               WEAK(self)

#define STRONG_WITH_NAME_OBJECT(_obj, _name)    __strong typeof(_obj) strong##_name = _obj
#define STRONG(_obj)                            STRONG_WITH_NAME_OBJECT(_obj, _obj)
#define STRONG_SELF                             STRONG(self)
#define IS_KINDOF_CLASS(_object, _class)        [_object isKindOfClass: [_class class]]

#pragma mark -
#pragma mark 路径
#define PATH_BUNDLE                                             [[NSBundle mainBundle] bundlePath]
#define PATH_DOCUMENTS                                          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_LIBRARY                                            [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_PRIVATE_STORAGE                                    [[PATH_LIBRARY stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"PrivateStorage"]
#define PATH_FOR_RESOURCE(file, ext)                            (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext] : nil)
#define PATH_FOR_RESOURCE_IN_DIRECTORY(file, ext, directory)    (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext inDirectory:directory] : nil)
#define TEMPORARY_FILE_PATH                                     [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]]]
#define REMOVE_ITEM_AT_PATH(path)                               [FILE_MANAGER removeItemAtPath:path error:nil]
#define FILE_EXISTS_AT_PATH(path)                               [FILE_MANAGER fileExistsAtPath:path]
#define PATH_APPEND(path,name)                                           [(path) stringByAppendingPathComponent:(name)];

#pragma mark -
#pragma mark 注释
#define GENERATE_PRAGMA(x) _Pragma(#x)
#define TODO(x) GENERATE_PRAGMA(message("[TODO] " x))
#define FIXME(x) GENERATE_PRAGMA(message("[FIXME] " x))
#define NOTE(x) GENERATE_PRAGMA(message("[NOTE] " x))

#pragma mark -
#pragma mark 系统程序调用
#define OPEN_URL(url)                                           [APPLICATION openURL:(url)]
#define OPEN_STRING_URL(url)                                    [APPLICATION openURL:[NSURL URLWithString:([url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])]]
#define CALL_NUMBER(number)                                     [APPLICATION openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:[number stringByReplacingOccurrencesOfString:@" " withString:@""]]]]

#pragma mark -
#pragma mark ** Assertion macros **

// Standard Assertions
#define ASSERT_NIL(x)           NSAssert4((x == nil), @"\n\n    ****  Unexpected Nil Assertion  ****\n    ****  Expected nil, but " #x @" is not nil.\nin file:%s at line %i in Method %@ with object:\n %@", __FILE__, __LINE__, NSStringFromSelector(_cmd), self)
#define ASSERT_NOT_NIL(x)       NSAssert4((x != nil), @"\n\n    ****  Unexpected Nil Assertion  ****\n    ****  Expected not nil, " #x @" is nil.\nin file:%s at line %i in Method %@ with object:\n %@", __FILE__, __LINE__, NSStringFromSelector(_cmd), self)
#define ASSERT_ALWAYS           NSAssert4(FALSE, @"\n\n    ****  Unexpected Assertion  **** \nAssertion in file:%s at line %i in Method %@ with object:\n %@", __FILE__, __LINE__, NSStringFromSelector(_cmd), self)
#define ASSERT_TRUE(test)       NSAssert4(test, @"\n\n    ****  Unexpected Assertion  **** \nAssertion in file:%s at line %i in Method %@ with object:\n %@", __FILE__, __LINE__, NSStringFromSelector(_cmd), self)
#define ASSERT_FALSE(test)      NSAssert4(!test, @"\n\n    ****  Unexpected Assertion  **** \nAssertion in file:%s at line %i in Method %@ with object:\n %@", __FILE__, __LINE__, NSStringFromSelector(_cmd), self)
#define ASSERT_WITH_MESSAGE(x)                  NSAssert5(FALSE, @"\n\n    ****  Unexpected Assertion  **** \nReason: %@\nAssertion in file:%s at line %i in Method %@ with object:\n %@", x, __FILE__, __LINE__, NSStringFromSelector(_cmd), self)
#define ASSERT_TRUE_WITH_MESSAGE(test, msg)     NSAssert5(test, @"\n\n    ****  Unexpected Assertion  **** \nReason: %@\nAssertion in file:%s at line %i in Method %@ with object:\n %@", msg, __FILE__, __LINE__, NSStringFromSelector(_cmd), self)
#define ASSERT_FALSE_WITH_MESSAGE(test, msg)    NSAssert5(!test, @"\n\n    ****  Unexpected Assertion  **** \nReason: %@\nAssertion in file:%s at line %i in Method %@ with object:\n %@", msg, __FILE__, __LINE__, NSStringFromSelector(_cmd), self)

// Useful, protective assertion macros
#define ASSERT_IS_CLASS(x, class)    NSAssert5([x isKindOfClass:class], @"\n\n    ****  Unexpected Class Assertion  **** \nReason: Expected class:%@ but got:%@\nAssertion in file:%s at line %i in Method %@\n\n", NSStringFromClass(class), x, __FILE__, __LINE__, NSStringFromSelector(_cmd))
#define SUBCLASSES_MUST_OVERRIDE     NSAssert2(FALSE, @"%@ Subclasses MUST override this method:%@\n\n", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#define SHOULD_NEVER_GET_HERE        NSAssert4(FALSE, @"\n\n    ****  Should Never Get Here  **** \nAssertion in file:%s at line %i in Method %@ with object:\n %@\n\n", __FILE__, __LINE__, NSStringFromSelector(_cmd), self)

// Blocks assertion, prevents NSAssert retain cycles in blocks
// http://getitdownonpaper.com/journal/2011/9/27/making-nsassert-play-nice-with-blocks.html
#if !defined(NS_BLOCK_ASSERTIONS)

#define BlockAssert(condition, desc, ...) \
do {\
if (!(condition)) { \
[[NSAssertionHandler currentHandler] handleFailureInFunction:NSStringFromSelector(_cmd) \
file:[NSString stringWithUTF8String:__FILE__] \
lineNumber:__LINE__ \
description:(desc), ##__VA_ARGS__]; \
}\
} while(0);

#else // NS_BLOCK_ASSERTIONS defined

#define BlockAssert(condition, desc, ...)

#endif

#pragma mark -
#pragma mark 访问安全

/*
 *  Strings
 */

#define	NSLS(str)   NSLocalizedString(str, nil)

#define IS_EMPTY_STRING(str)            (!(str) || ![(str) isKindOfClass:NSString.class] || [(str) length] == 0)
#define IS_POPULATED_STRING(str)        ((str) && [(str) isKindOfClass:NSString.class] && [(str) length] > 0)

/*
 * Dates
 */


#define IS_EMPTY_DATE(str)            (!(date) || ![(date) isKindOfClass:NSDate.class] || [(date) timeIntervalSince1970] == 0)
#define IS_POPULATED_DATE(date)        ((date) && [(date) isKindOfClass:NSDate.class] && [(date) timeIntervalSince1970] > 0)

/*
 *  Arrays
 */

#define IS_EMPTY_ARRAY(arr)             (!(arr) || ![(arr) isKindOfClass:NSArray.class] || [(arr) count] == 0)
#define IS_POPULATED_ARRAY(arr)         ((arr) && [(arr) isKindOfClass:NSArray.class] && [(arr) count] > 0)

/*
 *  Dictionaries
 */

#define IS_EMPTY_DICTIONARY(dic)        (!(dic) || ![(dic) isKindOfClass:NSDictionary.class] || [(dic) count] == 0)
#define IS_POPULATED_DICTIONARY(dic)    ((dic) && [(dic) isKindOfClass:NSDictionary.class] && [(dic) count] > 0)

#define NIL_TO_NSNULL(value)            (value ? value : [NSNull null])
#define NSNULL_TO_NIL(value)            ((id)value == [NSNull null] ? nil : value)

#pragma mark -
#pragma mark 快速定义属性
#define PP_BOOL(name)               @property (nonatomic, assign)   BOOL (name);
#define PP_STRING(name)             @property (nonatomic, copy)     NSString *(name);
#define PP_ARRAY(name)              @property (nonatomic, strong)   NSArray *(name);
#define PP_MUTABLE_ARRAY(name)      @property (nonatomic, strong)   NSMutableArray *(name);
#define PP_DICTIONARY(name)         @property (nonatomic, strong)   NSDictionary *(name);
#define PP_MUTABLE_DICTIONARY(name) @property (nonatomic, strong)   NSMutableDictionary *(name);
#define PP_INT(name)                @property (nonatomic, assign)   int (name);
#define PP_INTEGER(number)          @property (nonatomic, assign)   NSUInteger (number);
#define PP_VIEW(name)               @property (nonatomic, strong)   UIView *(name);
#define PP_IMAGE(name)              @property (nonatomic, strong)   UIImage *(name);
#define PP_IMAGEVIEW(name)          @property (nonatomic, strong)   UIImageView *(name);
#define PP_LABLE(name)              @property (nonatomic, strong)   UILabel *(name);
#define PP_TEXTFIELD(name)          @property (nonatomic, strong)   UITextField *(name);
#define PP_TABLEVIEW(name)          @property (nonatomic, strong)   UITableView *(name);
#define PP_TEXTVIEW(name)           @property (nonatomic, strong)   UITextView *(name);
#define PP_CONTROLLER(name)         @property (nonatomic, strong)   UIViewController *(name);

#define PP_STRONG(class,name)       @property (nonatomic, strong)   class *(name);
#define PP_ASSIGN(class,name)       @property (nonatomic, assign)   class *(name);
#define PP_DELEGATE(protocal,name)  @property (nonatomic, weak)     id<protocal> (name);

#pragma mark -
#pragma mark 函数块

static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

static inline NSString *StringFromObject(id object) {
    if (object == nil || [object isEqual:[NSNull null]]) {
        return @"";
    } else if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(stringValue)]){
        return [object stringValue];
    } else {
        return [object description];
    }
}

// 打印执行Block需要的时间
static inline void TimeThisBlock (void (^block)(void), NSString *message) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) {
        block();
        return;
    };
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    DLog(@"Took %f seconds to %@", (CGFloat)nanos / NSEC_PER_SEC, message);
}

//The helper function unpacks the object array and then calls through to NSDictionary to create the dictionary:
static inline NSDictionary *DictionaryWithIDArray(id *array, NSUInteger count) {
    id keys[count];
    id objs[count];
    
    for(NSUInteger i = 0; i < count; i++) {
        keys[i] = array[i * 2];
        objs[i] = array[i * 2 + 1];
    }
    
    return [NSDictionary dictionaryWithObjects: objs forKeys: keys count: count];
}


#endif
