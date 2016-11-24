//
//  NVAlertView.m
//  Navy
//
//  Created by Steven.Lin on 28/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVAlertView.h"
#import "NVBackgroundControl.h"
#import "NVButton.h"
#import "Macros.h"
#import "NVLabel.h"


@interface NVAlertAction ()
@property (nonatomic, copy) void(^handler)(NVAlertAction* action);
@property (nonatomic, strong) NVAlertController* alertController;
@end

@implementation NVAlertAction

+ (instancetype) actionWithTitle:(NSString *)title handler:(void(^)(NVAlertAction *))handler {
    NVAlertAction* action = [[NVAlertAction alloc] init];
    if (action) {
        action.title    = title;
        action.handler  = handler;
    }
    
    return action;
}

+ (instancetype) actionWithAttributedTitle:(NSAttributedString *)attributedTitle
                                   handler:(void (^)(NVAlertAction *))handler {
    NVAlertAction* action = [[NVAlertAction alloc] init];
    if (action) {
        action.title    = attributedTitle;
        action.handler  = handler;
    }
    
    return action;
}

- (void) onClick:(id)sender {
    
    if (self.alertController) {
        [self.alertController hide];
    }
    if (self.handler) {
        self.handler(self);
    }

}


@end




@interface NVAlertView : UIView
@property (nonatomic, readonly) NSArray<NVAlertAction *> *actions;

- (instancetype) initWithTitle:(NSString *)title
                       content:(NSString *)content;

- (void) addAction:(NVAlertAction*) action;

@end



@interface NVAlertView ()
<NVBackgroundControlDelegate,
UIWebViewDelegate>
@property (nonatomic, strong) NVLabel* uiTitle;
@property (nonatomic, strong) UIView* uiActionView;
@property (nonatomic, strong) NSMutableArray* arrayActions;
- (void) loadUrl:(NSURL*)url;
- (void) updateActionsDisplay;
- (void) updateContentViewDisplay;
- (void) onClick:(id)sender;
@end



#define VIEW_WIDTH     (240.0f * displayScale)
#define VIEW_HEIGHT    (240.0f * displayScale)
#define TAG_CONTENT_VIEW        10000
#define TAG_WEB_VIEW            10001


@implementation NVAlertView
@synthesize actions = _actions;


- (instancetype) init {
    self = [super initWithFrame:CGRectMake((APPLICATIONWIDTH - VIEW_WIDTH)/2,
                                           (APPLICATIONHEIGHT - VIEW_HEIGHT)/2,
                                           VIEW_WIDTH,
                                           VIEW_HEIGHT)];
    if (self) {
        self.backgroundColor            = COLOR_HM_WHITE_GRAY;
        
        self.layer.cornerRadius         = 12.0f * displayScale;
        self.layer.borderColor          = COLOR_HM_GRAY.CGColor;
        self.layer.borderWidth          = 0.5f;
        self.clipsToBounds              = YES;
        
        
        self.uiTitle                    = [[NVLabel alloc] initWithFrame:CGRectMake(20.0f, 5.0f, VIEW_WIDTH - 40.0f, 20.0f)];
        [self addSubview:self.uiTitle];
        self.uiTitle.font               = nvBoldFontWithSize(16.0f + fontScale);
        self.uiTitle.textAlignment      = NSTextAlignmentCenter;
        self.uiTitle.textColor          = COLOR_HM_BLACK;
    }
    
    return self;
}

- (instancetype) initWithTitle:(NSString *)title
                       content:(NSString *)content {
    self = [self init];
    if (self) {
        
        self.uiTitle.text       = title;
        
        NVLabel* contentView            = [[NVLabel alloc] initWithFrame:CGRectMake(20.0f,
                                                                                    30.0f,
                                                                                    VIEW_WIDTH - 20.0f*2,
                                                                                    VIEW_HEIGHT - 35.0f)];
        [self addSubview:contentView];
        contentView.tag                 = TAG_CONTENT_VIEW;
        contentView.textColor           = COLOR_HM_BLACK;
        contentView.font                = nvNormalFontWithSize(14.0f + fontScale);
        contentView.numberOfLines       = 0;
        contentView.text                = content;
        
    }
    
    return self;
}

- (instancetype) initWebAlertViewWithTitle:(NSString*)title {
    self = [self init];
    if (self) {
        
        self.uiTitle.text       = title;
        
        CGFloat scale           = APPLICATIONHEIGHT/APPLICATIONWIDTH;
        CGFloat width           = VIEW_WIDTH - 20.0f*2;
        UIWebView* webView      = [[UIWebView alloc] initWithFrame:CGRectMake(20.0f,
                                                                              30.0f,
                                                                              width,
                                                                              width * scale)];
        [self addSubview:webView];
        webView.tag             = TAG_WEB_VIEW;
        webView.backgroundColor = [UIColor clearColor];
        webView.delegate        = self;

    }
    
    return self;
}



- (void) addAction:(NVAlertAction *)action {
    if (_arrayActions == nil) {
        _arrayActions = [[NSMutableArray alloc] init];
    }
    
    [self.arrayActions addObject:action];
}

- (void) loadUrl:(NSURL *)url {
    UIWebView* webView  = (UIWebView*)[self viewWithTag:TAG_WEB_VIEW];
    if (webView) {
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void) updateActionsDisplay {
    if ([self.arrayActions count] == 0) {
        return;
    }
    
    [self updateContentViewDisplay];
    
    if (_uiActionView == nil) {
        _uiActionView       = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                       self.frame.size.height,
                                                                       VIEW_WIDTH,
                                                                       0.0f)];
        [self addSubview:_uiActionView];
        _uiActionView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    }
    
    for (id subview in _uiActionView.subviews) {
        if ([subview isKindOfClass:[UIView class]]) {
            [subview removeFromSuperview];
        } else if ([subview isKindOfClass:[CALayer class]]) {
            [subview removeFromSuperlayer];
        }
    }
    
    
    __block CGFloat x       = 0.0f;
    __block CGFloat y       = 0.0f;
    CGFloat const height    = 35.0f * displayScale;
    [self.arrayActions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVAlertAction* action       = (NVAlertAction*)obj;
        
        
        CGFloat width       = VIEW_WIDTH;
        if ([self.arrayActions count] == 2) {
            width           = VIEW_WIDTH / 2;
        }
        
        NVButton* button            = [[NVButton alloc] initWithFrame:CGRectMake(x,
                                                                                 y,
                                                                                 width,
                                                                                 height)];
        [self.uiActionView addSubview:button];
        button.normalColor          = COLOR_HM_WHITE_GRAY;
        button.buttonStyle          = NVButtonStyleFilled;
        if ([action.title isKindOfClass:[NSAttributedString class]]) {
            [button setAttributedTitle:action.title forState:UIControlStateNormal];
        } else if ([action.title isKindOfClass:[NSString class]]){
            [button setTitle:action.title forState:UIControlStateNormal];
            [button setTitleColor:COLOR_HM_BLUE forState:UIControlStateNormal];
            button.titleLabel.font      = nvNormalFontWithSize(16.0f + fontScale);
        }
        
        button.tag                  = idx;
        [button addTarget:action action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CALayer* line               = [CALayer layer];
        [self.uiActionView.layer addSublayer:line];
        line.frame                  = CGRectMake(0.0f, y, VIEW_WIDTH, 0.5f);
        line.backgroundColor        = COLOR_LINE.CGColor;
        
        
        if ([self.arrayActions count] == 2) {
            x += VIEW_WIDTH / 2;
            
            CALayer* line               = [CALayer layer];
            [self.uiActionView.layer addSublayer:line];
            line.frame                  = CGRectMake(VIEW_WIDTH/2, 0.0f, 0.5f, VIEW_HEIGHT);
            line.backgroundColor        = COLOR_LINE.CGColor;
            
        } else {
            y += height;
            
        }
    }];
    
    
    CGRect frame                = self.uiActionView.frame;
    frame.size.height           = ([self.arrayActions count] == 2) ? height : y;
    self.uiActionView.frame     = frame;
    
}


- (void) updateContentViewDisplay {
    CGFloat heightContent       = 40.0f;
    NVLabel* contentView        = (NVLabel*)[self viewWithTag:TAG_CONTENT_VIEW];
    if (contentView) {
        CGSize size = CGSizeZero;
        if ([contentView.attributedText length] > 0) {
            size = [contentView.attributedText boundingRectWithSize:CGSizeMake(VIEW_WIDTH - 40.0f, 1000000.0f)
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                            context:nil].size;
            
        } else if ([contentView.text length] > 0) {
            size = [contentView.text boundingRectWithSize:CGSizeMake(VIEW_WIDTH - 40.0f, 1000000.0f)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:ATTR_DICTIONARY(COLOR_HM_BLACK, 14.0f + fontScale)
                                                  context:nil].size;
        }
        
        if (size.height < 30.0f) {
            size.height     = 50.0f;
        }
        heightContent       = size.height;
        
        CGRect frame        = contentView.frame;
        frame.size.height   = heightContent;
        contentView.frame   = frame;
    }
    
    CGRect frame                = self.frame;
    frame.size.height           = heightContent + 30.0f;
    self.frame                  = frame;
}

- (void) layoutSubviews {
    [super layoutSubviews];

    CGRect frame                = self.frame;
    
    CGRect frameContent         = CGRectZero;
    NVLabel* contentView        = (NVLabel*)[self viewWithTag:TAG_CONTENT_VIEW];
    UIWebView* webView          = (UIWebView*)[self viewWithTag:TAG_WEB_VIEW];
    if (contentView) {
        frameContent            = contentView.frame;
    } else if (webView) {
        frameContent            = webView.frame;
    }
    
    CGRect frameAction          = self.uiActionView.frame;
    
    frame.size.height           = frameContent.origin.y + frameContent.size.height + frameAction.size.height + 10.0f;
    frame.origin.y              = (APPLICATIONHEIGHT - frame.size.height)/2;
    self.frame                  = frame;
    
    frameAction.origin.y        = frame.size.height - frameAction.size.height;
    self.uiActionView.frame     = frameAction;
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    CGSize size = webView.scrollView.contentSize;
//    
//    CGRect frame    = webView.frame;
//    frame.size      = size;
//    webView.frame   = frame;
//    
////    frame           = self.frame;
////    frame.size.height   = size.height + 30.0f;
////    self.frame          = frame;
//    
//    [self layoutSubviews];
}
@end



@interface NVAlertController ()
<NVBackgroundControlDelegate>
@property (nonatomic, strong) NVAlertView* uiAlterView;
@property (nonatomic, strong) NVBackgroundControl* uiBgControl;
@end


@implementation NVAlertController

+ (void) showAlterWithTitle:(NSString *)title content:(NSString *)content {
    
}

- (instancetype) initWithTitle:(NSString *)title content:(NSString *)content {
    self = [super init];
    if (self) {
        self.uiAlterView    = [[NVAlertView alloc] initWithTitle:title content:content];
    }
    
    return self;
}

- (void) addAction:(NVAlertAction *)action {
    action.alertController = self;
    [self.uiAlterView addAction:action];
}

- (void) show {
    
    [self.uiAlterView updateActionsDisplay];
    
    UIWindow* window        = [UIApplication sharedApplication].delegate.window;
    
    CGRect bounds = window.bounds;
    if (self.uiBgControl == nil) {
        self.uiBgControl    = [[NVBackgroundControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                                    0.0f,
                                                                                    bounds.size.width,
                                                                                    bounds.size.height)];
        
        
        [window addSubview:self.uiBgControl];
        self.uiBgControl.delegate      = self;
        [self.uiBgControl addSubview:self.uiAlterView];
        [self.uiBgControl show];
    }
    
}

- (void) hide {
    if (self.uiBgControl) {
        [self.uiBgControl hide];
        [self.uiBgControl removeFromSuperview];
        self.uiBgControl = nil;
    }
}

#pragma mark - NVBackgroundControlDelegate
- (void) didTouchUpInsideOnBackgroundControl:(NVBackgroundControl *)control {
    
}

@end



@implementation NVAlertController (NSAttributedString)

- (instancetype) initWithTitle:(NSString *)title attributedContent:(NSAttributedString *)attributedContent {
    self = [self initWithTitle:title content:@""];
    if (self) {
        NVLabel* contentView        = (NVLabel*)[self.uiAlterView viewWithTag:TAG_CONTENT_VIEW];
        if (contentView) {
            contentView.attributedText  = attributedContent;
        }
    }
    
    return self;
}

@end



@implementation NVAlertController (Webview)


- (instancetype) initWithTitle:(NSString *)title htmlContent:(NSString *)htmlContent {
    self = [super init];
    if (self) {
        self.uiAlterView    = [[NVAlertView alloc] initWebAlertViewWithTitle:title];
    }
    
    return self;
}

- (instancetype) initWithTitle:(NSString *)title url:(NSURL *)url {
    self = [super init];
    if (self) {
        self.uiAlterView    = [[NVAlertView alloc] initWebAlertViewWithTitle:title];
        
        [self.uiAlterView loadUrl:url];
    }
    
    return self;
}

@end



