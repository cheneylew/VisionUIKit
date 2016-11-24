//
//  NVButtonFooterView.h
//  Navy
//
//  Created by Steven.Lin on 19/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"
#import "NVTableViewFooterView.h"
#import "NVButton.h"


@protocol NVButtonTableViewFooterViewDelegate;


@interface NVButtonTableViewFooterView : NVTableViewFooterView
@property (nonatomic, strong, readonly) NVButton* button;
@property (nonatomic, assign) id<NVButtonTableViewFooterViewDelegate> delegate;
@end


@protocol NVButtonTableViewFooterViewDelegate <NSObject>
- (void) didClickButtonTableViewFooterView:(NVButtonTableViewFooterView*)cell;
@end


