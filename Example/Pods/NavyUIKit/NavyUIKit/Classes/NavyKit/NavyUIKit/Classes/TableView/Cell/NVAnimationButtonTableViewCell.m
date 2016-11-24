//
//  NVAnimationButtonTableViewCell.m
//  Navy
//
//  Created by Jelly on 8/25/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVAnimationButtonTableViewCell.h"
#import "NVAnimationButton.h"
#import <objc/runtime.h>


@implementation NVAnimationButtonDataModel

@end



@interface NVAnimationButtonTableViewCell ()
@property (nonatomic, strong) NVAnimationButton* button;
@property (nonatomic, copy) Class delegateClass;
- (void) buttonAction:(id)sender;
@end



#define CELL_HEIGHT     (60.0f * nativeScale() / 2)


@implementation NVAnimationButtonTableViewCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _button = [[NVAnimationButton alloc] initWithFrame:CGRectMake(20.0f * displayScale,
                                                                      10.0f * displayScale,
                                                                      APPLICATIONWIDTH - 40.0f * displayScale,
                                                                      CELL_HEIGHT - 20 * displayScale)];
        [self.contentView addSubview:_button];
        _button.titleLabel.font         = nvNormalFontWithSize(18.0f + fontScale);
        _button.buttonStyle             = NVButtonStyleFilled;
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.state = NVAnimationButtonStateNormal;
    }
    
    return self;
}


- (void) setObject:(id)object {
    if (self.item != object && object != nil) {
        self.item = object;
    }
    
    NVAnimationButtonDataModel* dataModel = (NVAnimationButtonDataModel*)self.item;
    if (dataModel.backgroundColor) {
        _button.normalColor = dataModel.backgroundColor;
    }
    
    if (dataModel.disableColor) {
        _button.disableColor = dataModel.disableColor;
    }
    
    _button.buttonStyle = dataModel.style;
    _button.enabled     = dataModel.enable;
    
    dataModel.cellInstance = self;
    self.delegate = dataModel.delegate;
    
    
    [self.button setNormal:^NVAnimationElement *{
        NVAnimationElement* element = [[NVAnimationElement alloc] init];
        element.buttonTitle = dataModel.normalTitle;
        return element;
    } loading:^NVAnimationElement *{
        NVAnimationElement* element = [[NVAnimationElement alloc] init];
        element.buttonTitle = dataModel.loadingTitle;
        return element;
    } complete:^NVAnimationElement *{
        NVAnimationElement* element = [[NVAnimationElement alloc] init];
        element.buttonTitle = dataModel.completeTitle;
        return element;
    } failure:^NVAnimationElement *{
        NVAnimationElement* element = [[NVAnimationElement alloc] init];
        element.buttonTitle = dataModel.failureTitle;
        return element;
    }];
}


- (void) setDelegate:(id<NVAnimationButtonTableViewCellDelegate>)delegate {
    _delegate = delegate;
    
    self.delegateClass = object_getClass(delegate);
}

- (void) buttonAction:(id)sender {
    
    if (self.state == NVAnimationButtonStateNormal) {
        BOOL result = YES;
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(willStartLoadingAtAnimationButtonTableViewCell:)]) {
            result = [self.delegate willStartLoadingAtAnimationButtonTableViewCell:self];
        }
        
        if (result) {
            [self.button startLoadingAnimation];
            self.state = NVAnimationButtonStateLoading;
            if (self.delegate &&
                [self.delegate respondsToSelector:@selector(animationButtonTableViewCell:didChangeState:)]) {
                [self.delegate animationButtonTableViewCell:self didChangeState:NVAnimationButtonStateLoading];
            }
        }
        
    } else if (self.state == NVAnimationButtonStateLoading ||
               self.state == NVAnimationButtonStateComplete ||
               self.state == NVAnimationButtonStateFailure) {
        
        NSString* selStrings[4] = {
            @"",
            @"startLoadingAnimation",
            @"startCompleteAnimation",
            @"startFailureAnimation",
        };
        
        [self.button performSelector:NSSelectorFromString(selStrings[self.state])];
        [self performSelector:@selector(callBack) withObject:nil afterDelay:1.35f];
        
    } else if (self.state == NVAnimationButtonStateRestore) {
        [self.button restore];
        self.state = NVAnimationButtonStateNormal;
//        [self performSelector:@selector(callBack) withObject:nil afterDelay:1.35f];
    }

}


- (void) callBack {

    if (self.delegate &&
        self.delegateClass == object_getClass(self.delegate) &&
        [self.delegate respondsToSelector:@selector(animationButtonTableViewCell:didChangeState:)]) {
        [self.delegate animationButtonTableViewCell:self didChangeState:self.state];
    }
}


- (void) startLoadingAnimation {
    self.state = NVAnimationButtonStateLoading;
    [self buttonAction:nil];
}

- (void) startCompleteAnimation {
    self.state = NVAnimationButtonStateComplete;
    [self buttonAction:nil];
}

- (void) startFailureAnimation {
    self.state = NVAnimationButtonStateFailure;
    [self buttonAction:nil];
}

- (void) restore {
    self.state = NVAnimationButtonStateRestore;
    [self buttonAction:nil];
}


+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}

@end
