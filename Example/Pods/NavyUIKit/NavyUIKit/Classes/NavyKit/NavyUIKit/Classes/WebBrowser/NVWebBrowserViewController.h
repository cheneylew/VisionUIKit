//
//  HYWebBrowserViewController.h
//  Haiyinhui
//
//  Created by Jelly on 7/15/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"
#import "NVJavaScriptObserver.h"
#import "NVAppSchemaObserver.h"
#import "NVWebView.h"

UIKIT_EXTERN  NSString* _Nonnull  const kNotificationWebViewControllerWillClosed;

@class NVWebBrowserViewController;

@protocol NVWebBrowserViewControllerDelegate <NSObject>

- (void)respondUrlSchemeWithWebBrowserViewController:(NVWebBrowserViewController * _Nonnull)webBroserViewController;

@end

@interface NVWebBrowserViewController : NVGlassMainViewController
@property (nonatomic, strong) NVWebView* _Nullable  nvWebView;
@property (nonatomic, strong) NSString* _Nullable   urlPath;
@property (nonatomic, strong) NSURL* _Nullable      baseURL;
@property (nonatomic, strong) NSString* _Nullable   loadHTMLString;
@property (nonatomic, strong) NVJavaScriptObserver* _Nullable javaScriptObserver;
@property (nonatomic, strong) NVAppSchemaObserver*  _Nullable appSchemaObserver;
@property (nonatomic, assign) id<NVWebBrowserViewControllerDelegate> _Nullable delegate;
@property (nonatomic, strong) UIColor* _Nullable    backBtnColor;                                //返回按钮的颜色
@property (nonatomic, copy)   NSString* _Nullable   naviTitle;                                  //导航栏标题，优先级要比系统title高，可以用这个修改导航栏title
@property (nonatomic, strong) NSString* _Nullable   defaultTitle;
@property (nonatomic, strong) NSString* _Nullable   deviceID;                                   //通过JSFramework提供给WebView调用原生的能力

/**
 *  一般使用情况[[NVWebBrowserViewController alloc] init]
 *  特殊情况需要让webview请求的时候post提交一些参数使用这个方法
 *
 *  @param params Request Post 提交的参数
 *
 *  @return 实例
 */
- (instancetype _Nullable)initWithRequestParams:(NSDictionary * _Nullable) params;

- (void) reload;
- (void) reloadUrl:(NSString* _Nullable)url;
- (void) loadHTMLString:(nullable NSString *)string baseURL:(nullable NSURL *)baseURL;
@end
