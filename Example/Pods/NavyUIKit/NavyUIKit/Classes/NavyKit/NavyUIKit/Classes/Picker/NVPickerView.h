//
//  NVPickerView.h
//  Navy
//
//  Created by Steven.Lin on 24/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"
#import "NVDataModel.h"

@interface NVPickerDataModel : NSObject
@property (nonatomic, strong) id title;
@property (nonatomic, strong) NSString* tag;
@end

@interface NVPickerListModel : NVListModel

@end



@protocol NVPickerViewDelegate;


@interface NVPickerView : UIView
@property (nonatomic, strong) NSArray* arrayPickerDataModel;
@property (nonatomic, assign) id<NVPickerViewDelegate> delegate;
@property (nonatomic, strong) UIColor* colorToolbar;
@property (nonatomic, strong) id title;
- (void) show;
- (void) showInView:(UIView*)view;
- (void) hide;
@end


@protocol NVPickerViewDelegate <NSObject>
- (void) pickerView:(NVPickerView*)pickerView didSelectItems:(NVPickerListModel*)listModel;
- (void) didDismissAtPickerView:(NVPickerView *)pickerView;
@end


