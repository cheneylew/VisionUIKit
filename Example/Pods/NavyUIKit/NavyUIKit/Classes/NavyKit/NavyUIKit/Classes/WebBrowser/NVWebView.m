//
//  NVWebView.m
//  Navy
//
//  Created by Steven.Lin on 10/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVWebView.h"
#import <WebKit/WebKit.h>


@interface NVWebView ()
<UIWebViewDelegate>


/**
 iOS7 使用
 */
@property (nonatomic, strong) UIWebView *uiWebView;

/**
 iOS8.0+用户使用
 */
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation NVWebView


#pragma mark - 初始化
- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self InitUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"NVWebView销毁成功");
    if (self.wkWebView) {
        [self.wkWebView removeObserver:self forKeyPath:@"title"];
    }
}

- (void) InitUI {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        _type = NVWebViewTypeWKWebView;
    }else {
        _type = NVWebViewTypeUIWebView;
    }
    
    if (self.type == NVWebViewTypeWKWebView) {
        // 配置WKWebView
        WKWebViewConfiguration *config              = [[WKWebViewConfiguration alloc] init];
        
        config.preferences                          = [[WKPreferences alloc] init];
        config.preferences.minimumFontSize          = 10;               // 默认是0
        config.preferences.javaScriptEnabled        = YES;              // 默认YES
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;  // 默认NO
        // web内容处理池
        config.processPool                          = [[WKProcessPool alloc] init];
        
        // js与web内容交互
        WKUserContentController *userCC = [[WKUserContentController alloc] init];
        config.userContentController = userCC;
        
        // 创建
        CGRect frame = self.frame;
        frame.size.height = frame.size.height;
        WKWebView *webView = [[WKWebView alloc] initWithFrame:frame configuration:config];
        webView.UIDelegate = self.wkUIDelegate;
        webView.navigationDelegate = self.wkNavigationDelegate;
        webView.allowsBackForwardNavigationGestures = YES;
        webView.scrollView.decelerationRate     = 0.998;
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.wkWebView = webView;
        [self addSubview:webView];
        
        [self.wkWebView addObserver:self
                         forKeyPath:@"title"
                            options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                            context:nil];
    }else {
        UIWebView *webView                      = [[UIWebView alloc] initWithFrame:self.bounds];
        webView.autoresizingMask                = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        webView.scalesPageToFit                 = NO;
        webView.scrollView.decelerationRate     = 0.998;
        webView.delegate                        = self.uiWebViewDelegate;
        self.uiWebView                          = webView;
        [self addSubview:webView];
    }
 
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        _title = [change objectForKey:@"new"];
        if (_delegate && [_delegate respondsToSelector:@selector(webView:titleChanged:)]) {
            [self.delegate webView:self titleChanged:_title];
        };
    }
}

#pragma mark - Setter Getter

- (void)setWkUIDelegate:(id<WKUIDelegate>)wkUIDelegate {
    if (_wkUIDelegate != wkUIDelegate) {
        _wkUIDelegate = wkUIDelegate;
    }
    self.wkWebView.UIDelegate = wkUIDelegate;
}

- (void)setUiWebViewDelegate:(id<UIWebViewDelegate>)uiWebViewDelegate {
    if (_uiWebViewDelegate != uiWebViewDelegate) {
        _uiWebViewDelegate = uiWebViewDelegate;
    }
    self.wkWebView.navigationDelegate = uiWebViewDelegate;
}

- (void)setWkNavigationDelegate:(id<WKNavigationDelegate>)wkNavigationDelegate {
    if (_wkNavigationDelegate != wkNavigationDelegate) {
        _wkNavigationDelegate = wkNavigationDelegate;
    }
    self.uiWebView.delegate = wkNavigationDelegate;
}

#pragma mark - 公开方法
- (void)evaluateJavaScript:(NSString *) javaScriptString
         completionHandler:(void (^)(id, NSError * error))completionHandler {
    if (self.type == NVWebViewTypeWKWebView) {
        [self.wkWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
    }else {
        NSString *result = [self.uiWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        completionHandler(result,nil);
    }
}

- (void) loadRequest:(NSURLRequest *)request {
    if (self.type == NVWebViewTypeWKWebView) {
        [self.wkWebView loadRequest:request];
    }else {
        [self.uiWebView loadRequest:request];
    }
}

- (void) loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    if (self.type == NVWebViewTypeWKWebView) {
        [self.wkWebView loadHTMLString:string baseURL:baseURL];
    }else {
        [self.uiWebView loadHTMLString:string baseURL:baseURL];
    }
}


- (BOOL) canGoBack {
    if (self.type == NVWebViewTypeWKWebView) {
        return [self.wkWebView canGoBack];
    }else {
        return [self.uiWebView canGoBack];
    }
}

- (BOOL) canGoForward {
    if (self.type == NVWebViewTypeWKWebView) {
        return [self.wkWebView canGoForward];
    }else {
        return [self.uiWebView canGoForward];
    }
}

- (void) goBack {
    if (self.type == NVWebViewTypeWKWebView) {
        [self.wkWebView goBack];
    }else {
        [self.uiWebView goBack];
    }
}

- (void) goForward {
    if (self.type == NVWebViewTypeWKWebView) {
        [self.wkWebView goForward];
    }else {
        [self.uiWebView goForward];
    }
}

- (void)reload {
    if (self.type == NVWebViewTypeWKWebView) {
        [self.wkWebView reload];
    }else {
        [self.uiWebView reload];
    }
}


@end


