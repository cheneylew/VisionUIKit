//
//  NVEnvironmentDeployViewController.h
//  Navy
//
//  Created by Jelly on 9/16/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"


@protocol NVEnvironmentDeployViewControllerDelegate;


@interface NVEnvironmentDeployViewController : NVTableViewController
@property (nonatomic, strong) NSString* typeOfSelection;
@property (nonatomic, assign) id<NVEnvironmentDeployViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDictionary* environments;
@end


@protocol NVEnvironmentDeployViewControllerDelegate <NSObject>
- (void) environmentDeployViewController:(NVEnvironmentDeployViewController*)viewController didSelectEnvironment:(NSString*)environment;
@end

