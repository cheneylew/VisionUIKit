//
//  VSTableViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTableViewController.h"
#import "VSButtonTableViewCell.h"
#import <UIViewController+RTRootNavigationController.h>
#import <KKCategories/KKCategories.h>
#import "VSInputManager.h"
#import "VSTitleImageTableViewCell.h"
#import "VSTextField.h"
#import "VSTBViewConstructor.h"
#import "UIImage+Bundle.h"

@interface VSTableViewController ()
<VSButtonTableViewCellDelegate>


@end

@implementation VSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"my table view";
}

- (NSArray<NSString *> *)vs_navigationBarRightItemsTitles {
    return @[@"更多", @"提现说明"];
}

- (void)vs_eventNavigationBarRightItemTouchedIndex:(NSUInteger)index {
    
}

- (void)vs_eventNavigationBarRightItemTouched:(UIBarButtonItem *)item {
    
}

- (void)vs_decorateNavigationBar:(UINavigationBar *)navigationBar {

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage vs_imageName:@"vs_navigation_back_normal"]
                                            style:UIBarButtonItemStylePlain
                                           target:target action:action];
    item.tintColor = [UIColor whiteColor];
    return item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Class)vs_constructorClass {
    return [VSTBViewConstructor class];
}

- (void)vs_constructorData {
    
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
            [tableView reloadRowsAtIndexPaths:@[[weakself.TBConstructor vs_indexPathOfModel:weakm]]
                             withRowAnimation:UITableViewRowAnimationFade];
        }];
    }else if ([model.identifier isEqualToString:@"com.cell.b"]) {
        VSTableViewController *tb = [[VSTableViewController alloc] init];
        [self.navigationController pushViewController:tb animated:YES];
    }
}

- (void)VSButtonTableViewCellWithButtonClickEvent:(UIButton *)btn model:(VSTBBaseDataModel *)model {
    
}

@end
