//
//  NVAlertView.h
//  Navy
//
//  Created by Steven.Lin on 28/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NVAlertAction : NSObject
@property (nonatomic, strong) id title;
+ (instancetype) actionWithTitle:(NSString *)title handler:(void (^)(NVAlertAction *action))handler;
+ (instancetype) actionWithAttributedTitle:(NSAttributedString *)attributedTitle handler:(void (^)(NVAlertAction *action))handler;
@end






@interface NVAlertController : NSObject
+ (void) showAlterWithTitle:(NSString*)title content:(NSString*)content;
- (instancetype) initWithTitle:(NSString*)title content:(NSString *)content;
- (void) addAction:(NVAlertAction*)action;
- (void) show;
- (void) hide;
@end


@interface NVAlertController (NSAttributedString)
- (instancetype) initWithTitle:(NSString *)title attributedContent:(NSAttributedString *)attributedContent;
@end


@interface NVAlertController (Webview)
- (instancetype) initWithTitle:(NSString *)title htmlContent:(NSString *)htmlContent;
- (instancetype) initWithTitle:(NSString *)title url:(NSURL *)url;
@end

