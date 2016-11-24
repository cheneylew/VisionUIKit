//
//  NVDatePickerView.h
//  Navy
//
//  Created by Steven.Lin on 25/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol NVDatePickerViewDelegate;


@interface NVDatePickerView : UIView
@property (nonatomic, assign) id<NVDatePickerViewDelegate> delegate;
@property (nonatomic, strong) UIColor* colorToolbar;
@property (nonatomic, strong) NSDate* minimumDate;
@property (nonatomic, strong) NSDate* maximumDate;
- (void) show;
- (void) showInView:(UIView*)view;
- (void) hide;
@end



@protocol NVDatePickerViewDelegate <NSObject>
- (void) datePickerView:(NVDatePickerView*)pickerView didSelectDateTime:(NSString*)dateTime;
- (void) didDismissAtPickerView:(NVDatePickerView *)pickerView;
@end


