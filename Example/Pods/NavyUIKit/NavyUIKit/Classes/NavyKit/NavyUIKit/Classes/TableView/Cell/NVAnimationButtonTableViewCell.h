//
//  NVAnimationButtonTableViewCell.h
//  Navy
//
//  Created by Jelly on 8/25/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"
#import "NVButtonTableViewCell.h"



@interface NVAnimationButtonDataModel : NVButtonDataModel
@property (nonatomic, strong) NSString* normalTitle;
@property (nonatomic, strong) NSString* loadingTitle;
@property (nonatomic, strong) NSString* completeTitle;
@property (nonatomic, strong) NSString* failureTitle;
@end




typedef NS_ENUM(NSUInteger, NVAnimationButtonState) {
    NVAnimationButtonStateNormal,
    NVAnimationButtonStateLoading,
    NVAnimationButtonStateComplete,
    NVAnimationButtonStateFailure,
    NVAnimationButtonStateRestore,
};

@protocol NVAnimationButtonTableViewCellDelegate;


@interface NVAnimationButtonTableViewCell : NVTableViewNullCell
@property (nonatomic, assign) id<NVAnimationButtonTableViewCellDelegate> delegate;
@property (nonatomic, assign) NVAnimationButtonState state;
- (void) startLoadingAnimation;
- (void) startCompleteAnimation;
- (void) startFailureAnimation;
- (void) restore;
@end


@protocol NVAnimationButtonTableViewCellDelegate <NSObject>
- (BOOL) willStartLoadingAtAnimationButtonTableViewCell:(NVAnimationButtonTableViewCell*)cell;
- (void) animationButtonTableViewCell:(NVAnimationButtonTableViewCell*)cell didChangeState:(NVAnimationButtonState)state;
@end



