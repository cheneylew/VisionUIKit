//
//  VSAlertView.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/15.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSAlertView.h"

#define VSSCREEN_SIZE [[UIScreen mainScreen] bounds]
#define VSSCREEN_WIDTH VSSCREEN_SIZE.size.width
#define VSSCREEN_HEIGHT VSSCREEN_SIZE.size.height
#define VSBUTTON_HEIGHT 40.0f

@interface VSAlertView()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *dialogView;
@property (nonatomic, strong) UIView *buttonsView;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *buttonTitles;

@property (nonatomic, copy) VSAlertViewJKCallBackBlock callBack;

@end

@implementation VSAlertView

- (CGFloat)heightWithString:(NSString *)string Font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
    
    return ceil(textSize.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *maskView = [[UIView alloc] initWithFrame:frame];
        maskView.backgroundColor = [UIColor lightGrayColor];
        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        maskView.layer.opacity = 0.2;
        self.maskView = maskView;
        [self addSubview:self.maskView];
    }
    return self;
}

- (void)makeLayout {
    UIFont *msgFont = [UIFont systemFontOfSize:14];
    
    CGFloat dWidth = VSSCREEN_WIDTH*4/5;
    CGFloat mHeight = [self heightWithString:self.message
                                        Font:msgFont
                          constrainedToWidth:dWidth];
    if (mHeight < 50) {
        mHeight = 50;
    }
    CGFloat dHeight = mHeight+VSBUTTON_HEIGHT;
    
    UIView *dialogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
    dialogView.backgroundColor = [UIColor whiteColor];
    dialogView.layer.cornerRadius = 4.0f;
    dialogView.center = self.center;
    [self addSubview:dialogView];
    self.dialogView = dialogView;

    
    //buttons
    if (self.buttonTitles.count) {
        CGFloat btnWidth = dWidth/self.buttonTitles.count;
        CGFloat btnY = dHeight-VSBUTTON_HEIGHT;
        [self.buttonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *btnTitle = obj;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = idx;
            [button setTitle:btnTitle forState:UIControlStateNormal];
            [button addTarget:self
                       action:@selector(btnClick:)
             forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(btnWidth*idx,
                                      btnY,
                                      btnWidth,
                                      VSBUTTON_HEIGHT);
            [dialogView addSubview:button];
        }];
        
        // add button top line
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btnY, dWidth, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [dialogView addSubview:line];
    }
    
    //message label
    if (self.message.length) {
        UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dWidth, mHeight)];
        msgLabel.text = self.message;
        msgLabel.font = msgFont;
        msgLabel.numberOfLines = 0;
        [dialogView addSubview:msgLabel];
    }
}

- (void)btnClick:(UIButton *)button {
    if (self.callBack) {
        self.callBack(button.tag);
        [self closeAlertView];
    }
}

- (void)closeAlertView {
    [self removeFromSuperview];
}

- (void)dealloc {
    NSLog(@"VSAlertView 销毁了");
}

+ (void)AlertWithTitle:(NSString *)title
                message:(NSString *)message
           buttonTitles:(NSArray *)btnTitles
              callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    VSAlertView *alertView = [[VSAlertView alloc] initWithFrame:bounds];
    alertView.title = title;
    alertView.message = message;
    alertView.buttonTitles = btnTitles;
    alertView.callBack = alertViewCallBackBlock;
    [alertView makeLayout];
    [keyWindow addSubview:alertView];
}

@end
