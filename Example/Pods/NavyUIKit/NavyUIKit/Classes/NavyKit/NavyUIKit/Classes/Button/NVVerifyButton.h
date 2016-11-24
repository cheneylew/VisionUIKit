//
//  NVVerifyButton.h
//  Navy
//
//  Created by Jelly on 7/29/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "Macros.h"
#import "NVButton.h"


typedef NS_ENUM(NSInteger, NVVerifyButtonState) {
    NVVerifyButtonStateStartCountDown,
    NVVerifyButtonStateStopCountDown,
};


@protocol NVVerifyButtonDelegate;

@interface NVVerifyButton : NVButton
@property (nonatomic, assign) CGFloat countDown;
@property (nonatomic, assign) id<NVVerifyButtonDelegate> delegate;
- (void) startCountDown;
- (void) stopCountDown;
@end


@protocol NVVerifyButtonDelegate <NSObject>
- (void) verifyButton:(NVVerifyButton*)button didChangeState:(NVVerifyButtonState)state;
@end



