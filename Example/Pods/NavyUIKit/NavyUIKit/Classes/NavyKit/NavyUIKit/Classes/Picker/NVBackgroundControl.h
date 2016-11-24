//
//  NVBackgroundControl.h
//  Navy
//
//  Created by Steven.Lin on 24/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NVBackgroundControlDelegate;


@interface NVBackgroundControl : UIControl
@property (nonatomic, assign) id<NVBackgroundControlDelegate> delegate;
- (void) show;
- (void) hide;
@end


@protocol NVBackgroundControlDelegate <NSObject>
- (void) didTouchUpInsideOnBackgroundControl:(NVBackgroundControl*)control;
@end

