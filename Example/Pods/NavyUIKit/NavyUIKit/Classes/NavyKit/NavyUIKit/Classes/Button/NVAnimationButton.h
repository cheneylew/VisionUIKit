//
//  NVAnimationButton.h
//  Navy
//
//  Created by Jelly on 8/20/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVButton.h"




@interface NVAnimationElement : NSObject
@property (nonatomic, strong) NSString* buttonTitle;
@property (nonatomic, strong) UIColor* buttonColor;
@property (nonatomic, assign) CGFloat delay;
@end



typedef NS_ENUM(NSUInteger, NVAnimationType) {
    NVAnimationTypeFromButtom,
    NVAnimationTypeFromRight,
};


@interface NVAnimationButton : NVButton
@property (nonatomic, assign) NVAnimationType animationType;
- (void) setNormal:(NVAnimationElement* (^)())normalElement
           loading:(NVAnimationElement* (^)())loadingElement
          complete:(NVAnimationElement* (^)())completeElement
           failure:(NVAnimationElement* (^)())failureElement;
- (void) startLoadingAnimation;
- (void) startCompleteAnimation;
- (void) startFailureAnimation;
- (void) restore;
@end
