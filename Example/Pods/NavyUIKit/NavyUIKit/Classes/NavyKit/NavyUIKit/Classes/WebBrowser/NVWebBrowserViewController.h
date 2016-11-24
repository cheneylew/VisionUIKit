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

UIKIT_EXTERN NSString* const kNotificationWebViewControllerWillClosed;

@class NVWebBrowserViewController;

@protocol NVWebBrowserViewControllerDelegate <NSObject>

- (void)respondUrlSchemeWithWebBrowserViewController:(NVWebBrowserViewController *)webBroserViewController;

@end

@interface NVWebBrowserViewController : NVGlassMainViewController
@property (nonatomic, strong) NVWebView* nvWebView;
@property (nonatomic, strong) NSString* urlPath;
@property (nonatomic, strong) NSURL* baseURL;
@property (nonatomic, strong) NSString* loadHTMLString;
@property (nonatomic, strong) NVJavaScriptObserver* javaScriptObserver;
@property (nonatomic, strong) NVAppSchemaObserver* appSchemaObserver;
@property (nonatomic, assign) id<NVWebBrowserViewControllerDelegate> delegate;
@property (nonatomic, strong) UIColor *backBtnColor;                                //返回按钮的颜色
@property (nonatomic, copy) NSString *naviTitle;                                    //导航栏标题，优先级要比系统title高，可以用这个修改导航栏title
@property (nonatomic, strong) NSString* defaultTitle;
@property (nonatomic, strong) NSString* deviceID;                                   //通过JSFramework提供给WebView调用原生的能力

/**
 *  一般使用情况[[NVWebBrowserViewController alloc] init]
 *  特殊情况需要让webview请求的时候post提交一些参数使用这个方法
 *
 *  @param params Request Post 提交的参数
 *
 *  @return 实例
 */
- (instancetype)initWithRequestParams:(NSDictionary *) params;

- (void) reload;
- (void) reloadUrl:(NSString*)url;
- (void) loadHTMLString:(nullable NSString *)string baseURL:(nullable NSURL *)baseURL;
@end
