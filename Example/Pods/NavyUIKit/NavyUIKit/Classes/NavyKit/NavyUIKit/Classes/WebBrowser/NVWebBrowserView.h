//
//  NVWebBrowserView.h
//  Navy
//
//  Created by Steven.Lin on 13/4/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NVWebBrowserView : UIView
@property (nonatomic, copy) void(^linkClickedBlock)(NSURL* url);
@property (nonatomic, strong, readonly) NSURL* url;
- (void)loadRequest:(nullable NSURLRequest *)request;
- (void)loadHTMLString:(nullable NSString *)string baseURL:(nullable NSURL *)baseURL;
@end
