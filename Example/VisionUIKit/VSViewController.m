//
//  VSViewController.m
//  VisionUIKit
//
//  Created by Deju Liu on 11/15/2016.
//  Copyright (c) 2016 Deju Liu. All rights reserved.
//

#import "VSViewController.h"
#import "VSAlertView.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>
#import "VSSheetView.h"
#import "VSTableViewController.h"
#import "VSInputManager.h"
#import "NSMutableAttributedString+Category.h"
#import "VSHttpClient.h"

#define TITLE_COLOR RGB(15, 103, 197)

@interface VSViewController ()
<TTTAttributedLabelDelegate>

PP_STRONG(UIScrollView, scrollView)

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.title = @"效果展示";
    self.view.backgroundColor = RGB(245, 245, 245);
    [self makeScrollView];
    [self makeLeftButtons];
    [self makeRightButtons];
}


- (void)viewWillAppear:(BOOL)animated {
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 定制按钮

- (void)makeLeftButtons{
    [[self makeLeftButton:@"SheetView" index:0] jk_addActionHandler:^(NSInteger tag) {
        [VSSheetView ShowWithbuttonTitles:@[@"相机",@"相册"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
            //
        }];
    }];
    
    [[self makeLeftButton:@"SheetView_Custom" index:1] jk_addActionHandler:^(NSInteger tag) {
        UIView *f = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        f.backgroundColor = [UIColor redColor];
        [VSSheetView ShowWithCustomView:f callBlock:^(NSInteger buttonIndex) {
            
        }];
    }];
    
    [[self makeLeftButton:@"AlertView-类系统" index:2] jk_addActionHandler:^(NSInteger tag) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Hello World\n"];
        [attributedString appendString:@"确认奖励信息" withAttributes:@{ATT_TEXT_COLOR:[UIColor blackColor],ATT_FONT:[UIFont systemFontOfSize:16]}];
        [attributedString addLine:2];
        
        [attributedString appendString:@"\t体验金额:\t\t" withAttributes:@{ATT_TEXT_COLOR:[UIColor blackColor],ATT_FONT:[UIFont systemFontOfSize:16]}];
        [attributedString appendString:@"10元"
                        withAttributes:@{ATT_TEXT_COLOR:[UIColor blackColor],ATT_FONT:[UIFont systemFontOfSize:16]}];
        [attributedString addLine:1];
        
        [attributedString appendString:@"\t体验金额:\t\t" withAttributes:@{ATT_TEXT_COLOR:[UIColor blackColor],ATT_FONT:[UIFont systemFontOfSize:16]}];
        [attributedString appendString:@"10元"
                        withAttributes:@{ATT_TEXT_COLOR:[UIColor blackColor],ATT_FONT:[UIFont systemFontOfSize:16]}];
        [attributedString addLine:1];
        
        [attributedString appendString:@"\t体验金额:\t\t" withAttributes:@{ATT_TEXT_COLOR:[UIColor blackColor],ATT_FONT:[UIFont systemFontOfSize:16]}];
        [attributedString appendString:@"10元"
                        withAttributes:@{ATT_TEXT_COLOR:[UIColor blackColor],ATT_FONT:[UIFont systemFontOfSize:16]}];
        [attributedString addLine:1];
        
        VSAlertView *alert = [VSAlertView ShowWithTitle:@"提示" message:attributedString buttonTitles:@[@"确定",@"取消"] callBlock:^(NSInteger buttonIndex) {
            //
        }];
        alert.messageTextAlignment = NSTextAlignmentLeft;
    }];
    
    [[self makeLeftButton:@"AlertView-点击蒙版关闭" index:3] jk_addActionHandler:^(NSInteger tag) {
        VSAlertView *alertView = [VSAlertView ShowWithTitle:nil message:@"有市场就得上呗君不见微软发布会上那么多信仰灯况且现在微软也跟着苹果学坏了搞高调撩妹式营销生产端来渗透MAC用户市场也是很正常的事情有市场就得上呗君不见微软发布会上那么多信仰灯况且现在微软也跟着苹果学坏了搞高调撩妹式营销生产端来渗透MAC用户市场也是很正常的事情有市场就得上呗君不见微软发布会上那么多信仰灯况且现在微软也跟着苹果学坏了搞高调撩妹式营销生产端来渗透MAC用户市场也是很正常的事情" buttonTitles:nil callBlock:^(NSInteger buttonIndex) {
            //
        }];
        [alertView enableTapMaskClose:YES];
    }];
    
    [[self makeLeftButton:@"AlertView-点击蒙版关闭" index:4] jk_addActionHandler:^(NSInteger tag) {
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
        [attr appendString:@"如您需要继续使用自动投标服务，请：\n1.完成实名认证\n2.阅读并同意《自动投标委托服务协议》\n否则海银会将于12月20日18点关闭您的自动投标服务。" withAttributes:@{ATT_FONT:[UIFont systemFontOfSize:12]}];
        VSAlertView *alertView = [VSAlertView ShowInView:self.view
                          Title:@""
                        message:attr
                   buttonTitles:@[@"取消",@"实名认证"]
                      callBlock:^(NSInteger buttonIndex) {
            
        }];
        alertView.messageTextAlignment = NSTextAlignmentLeft;
    }];
    
    [[self makeLeftButton:@"CCLogSystem" index:5] jk_addActionHandler:^(NSInteger tag) {
        [VSSheetView ShowWithbuttonTitles:@[@"查看日志",@"制造Crash",@"生成日志",@"多线程crash",@"NSLog"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
            switch (buttonIndex) {
                    case 1:
                {
                    [CCLogSystem activeDeveloperUI];
                }
                    break;
                    case 2:
                {
                    NSArray *att = @[@"adfasdf"];
                    [att objectAtIndex:2];
                }
                    break;
                    case 3:
                {
                    for (int i=0; i<100; i++) {
                        CC_LOG_VALUE(@"hello world");
                    }
                }
                    break;
                    case 4:
                {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSArray *att = @[@"adfasdf"];
                        [att objectAtIndex:2];
                    });
                }
                    break;
                    case 5:
                    NSLog(@"this my log!");
                    CC_LOG_VALUE(@"log====");
                    break;
                default:
                    break;
            }
        }];
    }];
}

- (void)makeRightButtons{
    [[self makeRightButton:@"隐藏显示NavigationBar" index:0] jk_addActionHandler:^(NSInteger tag) {
        [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    }];
    
    [[self makeRightButton:@"TableView" index:1] jk_addActionHandler:^(NSInteger tag) {
        VSTableViewController *tb = [[VSTableViewController alloc] init];
        [self.navigationController pushViewController:tb animated:YES];
    }];
    
    [[self makeRightButton:@"NSAttributeString" index:2] jk_addActionHandler:^(NSInteger tag) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"hello world"];
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:[UIColor redColor]
                           range:NSMakeRange(0, 4)];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, 300, 200)];
        textLabel.attributedText = attrString;
        [self.view addSubview:textLabel];
    }];
    
    [[self makeRightButton:@"TTTAttributedLabel" index:3] jk_addActionHandler:^(NSInteger tag) {
        TTTAttributedLabel *lbl = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49-50, 300, 50)];
        lbl.backgroundColor = [UIColor lightGrayColor];
        lbl.numberOfLines = 0;
        lbl.width = 100;
        lbl.bottom = SCREEN_HEIGHT - 200;
        
        lbl.linkAttributes = @{ATT_FONT:[UIFont systemFontOfSize:22],
                               ATT_TEXT_COLOR:[UIColor purpleColor],
                               ATT_UNDERLINE_COLOR:[UIColor purpleColor],
                               ATT_UNDERLINE_STYLE:@1,};
        lbl.text = @"hello world 点击百度 点击新浪";
        [lbl setText:lbl.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            [mutableAttributedString dj_addAttribute:kTTTBackgroundFillColorAttributeName value:[UIColor yellowColor] string:@"hello world"];
            return mutableAttributedString;
        }];
        lbl.delegate = self;
        [self.view addSubview:lbl];
        
        lbl.height = [lbl.attributedText dj_heightWithWidth:lbl.width];
        [lbl dj_addLinkToURLString:@"http://www.baidu.com" subString:@"点击百度"];
        [lbl dj_addLinkToURLString:@"http://www.sina.com.cn" subString:@"点击新浪"];
    }];
    
    [[self makeRightButton:@"InputView" index:4] jk_addActionHandler:^(NSInteger tag) {
        VSInputManager *m = [VSInputManager sharedInstance];
        [m inputWeb:@"" complation:^(NSString *result, BOOL cancel) {
            
        }];
    }];
    
    [[self makeRightButton:@"AFNetWorking-Post" index:5] jk_addActionHandler:^(NSInteger tag) {
        [[VSHttpClient sharedInstance] requestPost:@"ci/app/json" parameters:@{@"url":@"hello"} success:^(id responseObject) {
            //
        } failure:^(VSErrorDataModel *dataModel) {
            //
        }];
    }];
    
    [[self makeRightButton:@"AFNetWorking-Download" index:6] jk_addActionHandler:^(NSInteger tag) {
        [[VSHttpClient sharedInstance] downloadWithFileURL:[NSURL URLWithString:@"http://tupian.enterdesk.com/2013/mxy/12/10/15/3.jpg"] progress:^(NSProgress *downloadProgress) {
            DLog(@"progress:%lld %lld", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        } completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            DLog(@"downloaded:%@", filePath);
        }];
    }];
    
    [[self makeRightButton:@"AFNetWorking-Upload-file" index:7] jk_addActionHandler:^(NSInteger tag) {
        VSUploadFile *file = [VSUploadFile new];
        file.fileServerKey = @"file";
        file.localFileDIR = PATH_DOCUMENTS;
        file.localFileName = @"3.jpg";
        file.mimeType      = @"image/jpeg";
        DLog(@"uploaded");
        [[VSHttpClient sharedInstance] uploadToURLString:@"http://localhost/ci/app/upload_ipa" parameters:@{@"a":@"b"} uploadFiles:@[file] progress:^(NSProgress *progress) {
            //
        } success:^(id responseObject) {
            //
        } failure:^(VSErrorDataModel *dataModel) {
            //
        }];
    }];
    
    [[self makeRightButton:@"AFNetWorking-Upload-data" index:8] jk_addActionHandler:^(NSInteger tag) {
        UIImage *image = [UIImage imageNamed:@"avatar_login-1"];
        NSData *data = UIImagePNGRepresentation(image);
        [[VSHttpClient sharedInstance] uploadToURLString:@"http://localhost/ci/app/upload_ipa"
                                              parameters:@{@"a":@"b"}
                                                fileType:VSFileTypePNG
                                                fileData:data
                                               serverKey:@"file"
                                                progress:^(NSProgress *progress) {
            //
        } success:^(id responseObject) {
            //
        } failure:^(VSErrorDataModel *dataModel) {
            //
        }];
    }];
    
    [[self makeRightButton:@"AFNetWorking-Upload-data" index:9] jk_addActionHandler:^(NSInteger tag) {
        UIImage *image = [UIImage imageNamed:@"avatar_login-1"];
        NSData *data = UIImagePNGRepresentation(image);
        [[VSHttpClient sharedInstance] uploadToURLString:@"http://localhost/ci/app/upload_ipa"
                                              parameters:@{@"a":@"b"}
                                                fileData:data
                                                progress:^(NSProgress *progress) {
                                                    //
                                                } success:^(id responseObject) {
                                                    //
                                                } failure:^(VSErrorDataModel *dataModel) {
                                                    //
                                                }];
    }];
    
    [[self makeRightButton:@"AFNetWorking-Get" index:10] jk_addActionHandler:^(NSInteger tag) {
        [[VSHttpClient sharedInstance] requestGet:@"ci/app/json" parameters:@{@"url":@"hello"} success:^(id responseObject) {
            //
        } failure:^(VSErrorDataModel *dataModel) {
            //
        }];
    }];
}


- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [VSAlertView ShowWithTitle:@"" message:[url absoluteString] buttonTitles:nil callBlock:^(NSInteger buttonIndex) {

    }];
}

#pragma mark 通用方法

- (void)makeScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 2000);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (UIButton *)makeLeftButton:(NSString *)title index:(NSInteger) idx {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, idx*35, 150, 30);
    btn.left = 0;
    btn.backgroundColor = TITLE_COLOR;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2.0f;
    [self.scrollView addSubview:btn];
    return btn;
}

- (UIButton *)makeRightButton:(NSString *)title index:(NSInteger) idx {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, idx*35, 150, 30);
    btn.right = SCREEN_WIDTH;
    btn.backgroundColor = TITLE_COLOR;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2.0f;
    [self.scrollView addSubview:btn];
    return btn;
}

@end
