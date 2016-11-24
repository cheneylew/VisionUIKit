//
//  NVWebView.h
//  Navy
//
//  Created by Steven.Lin on 10/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NVWebViewDelegate;
@protocol WKNavigationDelegate;
@protocol WKUIDelegate;
@protocol WKScriptMessageHandler;

typedef enum : NSUInteger {
    NVWebViewTypeWKWebView,
    NVWebViewTypeUIWebView,
} NVWebViewType;

@interface NVWebView : UIView

/**
 iOS7 UIWebView代理
 */
@property (nullable, nonatomic, weak) id<UIWebViewDelegate> uiWebViewDelegate;

/**
 iOS8.0+ WKWebView代理
 */
@property (nullable, nonatomic, weak) id <WKNavigationDelegate> wkNavigationDelegate;
@property (nullable, nonatomic, weak) id <WKUIDelegate> wkUIDelegate;

@property (nullable, nonatomic, weak) id <NVWebViewDelegate> delegate;
@property (nonatomic, readonly, assign) NVWebViewType type;
@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nullable, nonatomic, strong) NSString *title;

- (void)loadRequest:(nullable NSURLRequest *)request;
- (void)loadHTMLString:(nullable NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)goBack;
- (void)goForward;
- (void)reload;
- (void)evaluateJavaScript:(NSString *) javaScriptString
         completionHandler:(void (^)(id, NSError * error))completionHandler;

@end



@protocol NVWebViewDelegate <NSObject>

- (BOOL )webView:(nullable NVWebView *)webView
shouldStartLoadWithRequest:(nullable NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType;

/**
 webview的标题改变回调

 @param webView  <#webView description#>
 @param newTitle <#newTitle description#>
 */
- (void )webView:(nullable NVWebView *)webView
    titleChanged:(NSString *) newTitle;

@end

