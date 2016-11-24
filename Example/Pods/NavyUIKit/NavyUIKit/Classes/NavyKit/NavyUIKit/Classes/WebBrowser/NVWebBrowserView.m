//
//  NVWebBrowserView.m
//  Navy
//
//  Created by Steven.Lin on 13/4/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVWebBrowserView.h"
#import "Macros.h"



@interface NVWebBrowserView ()
<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView* webView;
@end


@implementation NVWebBrowserView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor                        = COLOR_DEFAULT_WHITE;
        self.webView                                = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                      0.0f,
                                                                                      frame.size.width,
                                                                                      frame.size.height)];
        [self addSubview:self.webView];
        self.webView.backgroundColor                = COLOR_DEFAULT_WHITE;
        self.webView.delegate                       = self;
        self.webView.autoresizingMask               = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.webView.scrollView.decelerationRate    = 0.998;
        
    }
    
    return self;
}


- (void)loadRequest:(nullable NSURLRequest *)request {
    _url = request.URL;
    [self.webView loadRequest:request];
}

- (void)loadHTMLString:(nullable NSString *)string baseURL:(nullable NSURL *)baseURL {
    [self.webView loadHTMLString:string baseURL:baseURL];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    BOOL retval     = YES;
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        if (self.linkClickedBlock) {
            NSURL* url      = request.URL;
            self.linkClickedBlock(url);
            retval = NO;
        }
    }
    
    return retval;
}

@end



