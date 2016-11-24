//
//  DBImageView.h
//  DBImageView
//
//  Created by iBo on 25/08/14.
//  Copyright (c) 2014 Daniele Bogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBImage.h"

@interface DBImageView : UIView
@property (nonatomic, strong) DBImage *remoteImage;
@property (nonatomic, copy) NSString *imageWithPath;
@property (nonatomic, strong) UIImage *placeHolder, *image;
@property (nonatomic, assign) UIViewContentMode imageViewcontentMode;

+ (void) triggerImageRequests:(BOOL)start;
+ (void) clearCache;
@end
