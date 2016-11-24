//
//  NVSheetView.h
//  xiaochunlaile
//
//  Created by Steven.Lin on 6/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NVSheetView : UIView
@property (nonatomic, strong) id title;
@property (nonatomic, strong) id value;
@property (nonatomic, assign) NSTextAlignment valueAlignment;
@property (nonatomic, strong) UIColor* valueColor;
@end
