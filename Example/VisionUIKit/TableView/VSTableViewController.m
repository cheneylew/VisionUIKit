//
//  VSTableViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTableViewController.h"
#import "VSTBButtonCell.h"
#import <UIViewController+RTRootNavigationController.h>
#import <KKCategories/KKCategories.h>
#import "VSInputManager.h"
#import "VSTBTitleIconCell.h"

@interface DJNavigationBar : UINavigationBar

@end

@implementation DJNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景色透明
        [self setBackgroundImage:[UIImage jk_imageWithColor:HEX(0x383838)]
                   forBarMetrics:UIBarMetricsDefault];
        //发丝线透明
        [self setShadowImage:[UIImage jk_imageWithColor:[UIColor blueColor]]];
        
        //标题样式
        [self setTitleTextAttributes:@{ATT_TEXT_COLOR:[UIColor whiteColor],
                                       ATT_FONT:[UIFont systemFontOfSize:24]
                                       }];
    }
    return self;
}

@end

@interface VSTableViewController ()
<VSTBButtonCellDelegate>


@end

@implementation VSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"my table view";
    
    [self initNavigantionBar];
}

- (void)initNavigantionBar {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightItem)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (Class)rt_navigationBarClass {
    return [DJNavigationBar class];
}

- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back_normal"]
                                            style:UIBarButtonItemStylePlain
                                           target:target action:action];
    item.tintColor = [UIColor whiteColor];
    return item;
}

- (void)rightItem {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)vs_constructorClassName {
    return @"VSTBViewConstructor";
}

- (void)vs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(VSTBBaseDataModel *)model {
    if ([model.identifier isEqualToString:@"com.navi.hidden"]) {
        [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBar.hidden animated:YES];
    }else if([model.identifier isEqualToString:@"com.cell.c"]) {
        VSTBTitleIconDataModel *m = (VSTBTitleIconDataModel *)model;
        WEAK(m);
        WEAK_SELF;
        [VSInputManager InputText:m.title complation:^(NSString *result, BOOL cancel) {
            weakm.title = result;
            [tableView reloadRowsAtIndexPaths:@[[weakself.TBConstructor indexPathOfModel:weakm]]
                             withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}

- (void)VSTBButtonCellWithButtonClickEvent:(UIButton *)btn model:(VSTBBaseDataModel *)model {
    
}

@end
