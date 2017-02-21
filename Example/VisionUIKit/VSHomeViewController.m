//
//  VSViewController.m
//  VisionUIKit
//
//  Created by Deju Liu on 11/15/2016.
//  Copyright (c) 2016 Deju Liu. All rights reserved.
//

#import "VSHomeViewController.h"
#import "VSAlertView.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>
#import "VSSheetView.h"
#import "VSTableViewController.h"
#import "VSInputManager.h"
#import "NSMutableAttributedString+Category.h"
#import "VSHttpClient.h"
#import <Toast/UIView+Toast.h>
#import <DJNetworking/DJNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "VSUser.h"
#import "VSPhotoPickerViewController.h"
#import <DLPhotoPicker/DLPhotoPicker.h>
#import <ZLPhotoBrowser/ZLPhotoActionSheet.h>
#import <JYCarousel/JYCarousel.h>
#import <RTRootNavigationController.h>
#import "VSNetworkTableViewController.h"
#import "VSMVVMViewController.h"
#import <MGJRouter/MGJRouter.h>
#import <Task/Task.h>
#import "VSRouter.h"
#import "NSMutableArray+Sort.h"
#import "User.h"
#import "NSString+HTML.h"
//#import <XMNPhoto/XMNPhotoBrowserController.h>

#define TITLE_COLOR RGB(15, 103, 197)

@interface VSHomeViewController ()
<TTTAttributedLabelDelegate,
DLPhotoPickerViewControllerDelegate,
UINavigationControllerDelegate>

PP_STRONG(UIScrollView, scrollView)

@end

@implementation VSHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"效果展示";
    self.view.backgroundColor = RGB(245, 245, 245);
    [self makeScrollView];
    [self makeLeftButtons];
    [self makeRightButtons];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationController.navigationItem.leftBarButtonItem =  item;
    [self.scrollView setContentOffset:CGPointMake(0, 400)];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (BOOL)vs_tabItemHidden {
    return NO;
}

- (UIImage *)vs_tabItemUnselectedImage {
    return [UIImage imageNamed:@"assist_hl"];
}

- (UIImage *)vs_tabItemSelectedImage {
    return [UIImage imageNamed:@"assist_hl"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu {
    
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
    
    [[self makeLeftButton:@"AlertView-海银会大师" index:6] jk_addActionHandler:^(NSInteger tag) {
        [VSCBAlertView CBShowInView:self.view Title:nil
                                   message:@"刘德华刘德华刘德华刘德华刘德华刘德华刘德华刘德华刘德华1899999999918999999999189999999991899999999918999999999189999999991899999999918999999999"
                              buttonTitles:@[@"取消",@"确定",@"ok"]
                                 callBlock:^(NSInteger buttonIndex) {
                                     
                                 }];
    }];
    
    [[self makeLeftButton:@"Toast-提示" index:7] jk_addActionHandler:^(NSInteger tag) {
        for (int i=0; i<5; i++) {
            [CSToastManager setQueueEnabled:NO];
            [self.view makeToast:[NSString stringWithFormat:@"Created by Deju Liu %d", i] duration:2 position:CSToastPositionCenter];
        }
    }];
    
    [[self makeLeftButton:@"MBProgressHUD-Show" index:8] jk_addActionHandler:^(NSInteger tag) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Loading";
        hud.tag = 121212;
    }];
    
    [[self makeLeftButton:@"MBProgressHUD-Hide" index:9] jk_addActionHandler:^(NSInteger tag) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    [[self makeLeftButton:@"MVVM-Demo" index:10] jk_addActionHandler:^(NSInteger tag) {
        [self.navigationController pushViewController:[VSMVVMViewController new] animated:YES];
    }];
    
    [[self makeLeftButton:@"ImagesBrowser" index:11] jk_addActionHandler:^(NSInteger tag) {
        [self.navigationController pushViewController:[NSClassFromString(@"ImageBrowserViewController") new] animated:YES];
    }];
    
    [[self makeLeftButton:@"MGJRouter" index:12] jk_addActionHandler:^(NSInteger tag) {
        [VSSheetView ShowWithbuttonTitles:@[@"regist", @"open url", @"open url with user info", @"注册模糊匹配", @"打开模糊匹配"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
            #define TEMPLATE_URL @"mgj://search/:keyword"
            switch (buttonIndex) {
                case 1:
                {
                    [MGJRouter registerURLPattern:@"mgj://服务/网页" toHandler:^(NSDictionary *routerParameters) {
                        NSLog(@"routerParameterUserInfo:%@", routerParameters[MGJRouterParameterUserInfo]);
                        void (^completion)() = routerParameters[MGJRouterParameterCompletion];
                        if (completion) {
                            completion();
                        }
                    }];
                }
                    
                    break;
                case 2:
                    {
                        NSString *url = @"mgj://服务/网页?url=http%3a%2f%2fwww.baidu.com%2f%3fa%3da&param2=helloworld";
                        if ([MGJRouter canOpenURL:url]) {
                            [MGJRouter openURL:url];
                        }
                    }
                    break;
                case 3:
                {
                    [MGJRouter openURL:@"mgj://服务/网页" withUserInfo:@{@"a":@"b"} completion:^(id result) {
                        
                    }];
                }
                    break;
                case 4:
                {
                    [MGJRouter registerURLPattern:TEMPLATE_URL  toHandler:^(NSDictionary *routerParameters) {
                        NSLog(@"routerParameters[keyword]:%@", routerParameters[@"keyword"]); // Hangzhou
                    }];
                }
                    break;
                case 5:
                {
                    NSString *url = [MGJRouter generateURLWithPattern:TEMPLATE_URL parameters:@[@"Hangzhou"]];
                    [MGJRouter openURL:url];
                }
                    break;
                default:
                    break;
            }
        }];
    }];
    
    [[self makeLeftButton:@"TaskFlow" index:13] jk_addActionHandler:^(NSInteger tag) {
        [VSSheetView ShowWithbuttonTitles:@[@"TSKWorkflow"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 1:
                {
                    TSKWorkflow *workFlow = [[TSKWorkflow alloc] initWithName:@"my work flow"];
                    
                    TSKBlockTask *taskA = [[TSKBlockTask alloc] initWithName:@"A" block:^(TSKTask *task) {
                        id result = task.anyPrerequisiteResult;
                        NSSet *dependTasks = [task.workflow prerequisiteTasksForTask:task];
                    }];
                    TSKBlockTask *taskB = [[TSKBlockTask alloc] initWithName:@"B" block:^(TSKTask *task) {
                        [task finishWithResult:@"B Finished!"];
                    }];
                    [workFlow addTask:taskB prerequisites: nil];
                    [workFlow addTask:taskA prerequisites:taskB,nil];
                    [workFlow start];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                case 1000:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }];
    
    [[self makeLeftButton:@"VSRouter" index:14] jk_addActionHandler:^(NSInteger tag) {
        [VSSheetView ShowWithbuttonTitles:@[@"注册任务",@"打开URL", @"注册同步任务", @"打开同步任务"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [[VSRouter sharedInstance] initCommonTasks];
            } else if(buttonIndex == 2){
                [[VSRouter sharedInstance] initTasks];
            } else if(buttonIndex == 3){
                [VSRouter sync_registerServiceWithURLPattern:@"hyh://Service/sync" toHandler:^id(VSRouterParams *params) {
                    return @"ssssss";
                }];
            } else if(buttonIndex == 4){
                id obj = [VSRouter sync_openURL:@"hyh%3a%2f%2fService%2fsync%3fa%3d%e4%b8%ad%e6%96%87%26b%3dc"];
                NSLog(@"%@", obj);
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
//            [mutableAttributedString dj_addAttribute:kTTTBackgroundFillColorAttributeName value:[UIColor yellowColor] string:@"hello world"];
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
    
    [[self makeRightButton:@"VSHttpClient" index:5] jk_addActionHandler:^(NSInteger tag) {
        [VSSheetView ShowWithbuttonTitles:@[@"AFNetWorking-Post",
                                            @"AFNetWorking-Download",
                                            @"AFNetWorking-Upload-file",
                                            @"AFNetWorking-Upload-data",
                                            @"AFNetWorking-Upload-data",
                                            @"AFNetWorking-Get"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                for (int i=0; i<100; i++) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [[VSHttpClient sharedInstance] requestPost:@"ci/app/json" parameters:@{@"url":@"hello"} success:^(id responseObject) {
                            //
                        } failure:^(VSErrorDataModel *dataModel) {
                            //
                        }];
                    });
                }
            }else if (buttonIndex == 2) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.backgroundColor = [UIColor clearColor];
                hud.label.text = @"Loading";
                [[VSHttpClient sharedInstance] downloadWithFileURL:[NSURL URLWithString:@"http://tupian.enterdesk.com/2013/mxy/12/10/15/3.jpg"] progress:^(NSProgress *downloadProgress) {
                    DLog(@"progress:%lld %lld", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hud.progress = downloadProgress.completedUnitCount/(double)downloadProgress.totalUnitCount;
                    });
                } completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                    DLog(@"downloaded:%@", filePath);
                    [hud hideAnimated:YES];
                }];
            }else if (buttonIndex == 3) {
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
            }else if (buttonIndex == 4) {
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
            }else if (buttonIndex == 5) {
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
            }else if (buttonIndex == 6) {
                [[VSHttpClient sharedInstance] requestGet:@"" parameters:nil success:^(id responseObject) {
                    //
                } failure:^(VSErrorDataModel *dataModel) {
                    //
                }];
            }else if (buttonIndex == 7) {
                
            }else if (buttonIndex == 8) {
                
            }else if (buttonIndex == 9) {
                
            }
        }];
    }];
    
    [[self makeRightButton:@"DJNetWorking" index:6] jk_addActionHandler:^(NSInteger tag) {
        [[DJCenter defaultCenter] setupConfig:^(DJConfig * _Nonnull config) {
            config.consoleLog = YES;
            config.callbackQueue = dispatch_get_main_queue();
            config.generalServer = @"http://127.0.0.1";
            config.generalParameters = @{@"a":@"a1",@"b":@"b1"};
            config.generalHeaders = @{@"c":@"c1",@"d":@"d1"};
            config.generalUserInfo = @{@"userid":@"1234"};
        }];
        
        NSUInteger taskId = [[DJCenter defaultCenter] sendRequest:^(DJRequest * _Nonnull request) {
//            request.server = @"http://www.baidu.com/"
            request.api = @"/v1/api/userinfo";
            request.parameters = @{@"p":@"p1"};
        } onSuccess:^(id  _Nullable responseObject) {
            //
        } onFailure:^(NSError * _Nullable error) {
            //
        } onFinished:^(id  _Nullable responseObject, NSError * _Nullable error) {
            //
        }];
    }];
    
    [[self makeRightButton:@"MJExtentsion" index:7] jk_addActionHandler:^(NSInteger tag) {
       [VSSheetView ShowWithbuttonTitles:@[@"JSON->Model"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
           if (buttonIndex == 1) {
               NSString *jsonString = @"{\"name\":\"cheney\",\"height\":\"173.2\",\"sex\":\"boy\",\"books\":[{\"name\":\"a book name\"}]}";
               VSUser *user = [VSUser mj_objectWithKeyValues:jsonString];
               NSLog(@"");
           } else {
               //
           }
       }];
    }];
    
    [[self makeRightButton:@"Wechat-PhotoPicker" index:8] jk_addActionHandler:^(NSInteger tag) {
        VSPhotoPickerViewController *vc = [[VSPhotoPickerViewController alloc] init];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }];
    
    [[self makeRightButton:@"DLPhotoPicker-选取相册图片" index:9] jk_addActionHandler:^(NSInteger tag) {
        DLPhotoPickerViewController *picker = [[DLPhotoPickerViewController alloc] init];
        picker.delegate = self;
        picker.pickerType = DLPhotoPickerTypeDisplay;
        picker.navigationTitle = @"相册";
        
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    [[self makeRightButton:@"ZLPhotoBrowser" index:10] jk_addActionHandler:^(NSInteger tag) {
        ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
        //设置照片最大选择数
        actionSheet.maxSelectCount = 2;
        [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:nil completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
            NSLog(@"%@", selectPhotos);
        }];
    }];
    
    [[self makeRightButton:@"JYCarousel图片轮播" index:11] jk_addActionHandler:^(NSInteger tag) {
//            __weak typeof(self) weakSelf = self;
            //图片数组（或者图片URL，图片URL字符串，图片UIImage对象）
            NSMutableArray *imageArray = [[NSMutableArray alloc] initWithArray: @[@"personalHelp_4",@"personalHelp_4",@"personalHelp_4",@"personalHelp_4"]];
            JYCarousel *carouselView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 64, ViewWidth(self.view), 200) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
                //配置指示器类型
                carouselConfig.pageContollType = LabelPageControl;
                //配置轮播时间间隔
                carouselConfig.interValTime = 3;
                //配置轮播翻页动画
                carouselConfig.pushAnimationType = PushCube;
                //配置动画方向
                carouselConfig.animationSubtype = kCATransitionFromRight;
                return carouselConfig;
            } clickBlock:^(NSInteger index) {
                //点击imageView回调方法
//                [weakSelf clickIndex:index];
            }];
            //开始轮播
            [carouselView startCarouselWithArray:imageArray];
            [self.view addSubview:carouselView];
    }];
 
    [[self makeRightButton:@"TableView-Network" index:12] jk_addActionHandler:^(NSInteger tag) {
        VSNetworkTableViewController *tb = [[VSNetworkTableViewController alloc] init];
        [self.navigationController pushViewController:tb animated:YES];
    }];
    
    [[self makeRightButton:@"各种排序" index:13] jk_addActionHandler:^(NSInteger tag) {
        NSMutableArray<User *> *arr = [NSMutableArray array];
        int n = 1000;
        for (int i=0; i<n; i++) {
            int randInt = arc4random()%n;
            User *user = [[User alloc] initWithId:randInt];
            [arr addObject:user];
        }
        {
            NSTimeInterval s = [NSDate timeIntervalSinceReferenceDate];
            NSMutableArray *qArr = [arr mutableCopy];
            [VSSorter quickSort:qArr compare:^BOOL(User *obj1, User *obj2) {
                return obj1.userId < obj2.userId;
            }];
            NSTimeInterval e = [NSDate timeIntervalSinceReferenceDate];
            NSLog(@"quick耗时：%f", (double)(e-s));
        }
        
        {
            NSTimeInterval s = [NSDate timeIntervalSinceReferenceDate];
            NSMutableArray *mArr = [arr mutableCopy];
            [VSSorter mergeSort:mArr compare:^BOOL(User *obj1, User *obj2) {
                return obj1.userId < obj2.userId;
            }];
            NSTimeInterval e = [NSDate timeIntervalSinceReferenceDate];
            NSLog(@"merge耗时：%f", (double)(e-s));
        }
        
        {
            NSTimeInterval s = [NSDate timeIntervalSinceReferenceDate];
            [VSSorter insertionSort:[arr mutableCopy] compare:^BOOL(User *obj1, User *obj2) {
                return obj1.userId < obj2.userId;
            }];
            NSTimeInterval e = [NSDate timeIntervalSinceReferenceDate];
            NSLog(@"insert耗时：%f", (double)(e-s));
        }
        
        {
            NSTimeInterval s = [NSDate timeIntervalSinceReferenceDate];
            [VSSorter bubleSort:[arr mutableCopy] compare:^BOOL(User *obj1, User *obj2) {
                return obj1.userId < obj2.userId;
            }];
            NSTimeInterval e = [NSDate timeIntervalSinceReferenceDate];
            NSLog(@"buble耗时：%f", (double)(e-s));
        }
        
        NSLog(@"finished");
    }];
    [[self makeRightButton:@"html字符串去除" index:14] jk_addActionHandler:^(NSInteger tag) {
        NSString *html = @"你好<a href=\"http://ynet.media.baidu.com/\" target=\"_blank\">北京青年报</a><a href=\"http://ynet.media.baidu.com/\" target=\"_blank\">北京青年报</a><a href=\"http://ynet.media.baidu.com/\" target=\"_blank\">北京青年报</a><你好>";
        DLog(@"%@", [html kv_removeHTMLTag]);
        
        NSString * htmlString = @"一、项目特色&nbsp;<br />1、项目管理人为知名投资基金管理有限公司&nbsp;<br />2、在建工程及分摊面积土地、土地抵押；项目公司100%股权质押等有力风控措施。&nbsp;<br />二、项目区位：&nbsp;<br />1、顶级商圈：与人百商圈、新华集贸商圈构成省会城市“黄金三角”顶级商圈； &nbsp;<br />2、商务办公：中华商务、军创国际、尚德国际、金圆大厦、石房大厦、华海环球、国贸中心等，商务办公氛围浓厚； &nbsp;<br />3、金融服务：周边金融机构林立，人民银行、中行、工行、农行、交行、中信、光大、民生的分支机构； &nbsp;<br />4、绝佳交通：二十余条公交路线，1、3号线交叉口。<br />";
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[[htmlString kv_decodeHTMLCharacterEntities] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UILabel * myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
        myLabel.attributedText = attrStr;
        [self.view addSubview:myLabel];
    }];
}

#pragma mark - TTTAttributeLabel Delegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [VSAlertView ShowWithTitle:@"" message:[url absoluteString] buttonTitles:nil callBlock:^(NSInteger buttonIndex) {
        
    }];
}

#pragma mark - DLPhotoPicker Delegate
-(void)pickerController:(DLPhotoPickerViewController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    self.assets = [NSArray arrayWithArray:assets];
    
    // to operation with 'self.assets'
}

- (void)pickerControllerDidCancel:(DLPhotoPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)pickerController:(DLPhotoPickerViewController *)picker shouldScrollToBottomForPhotoCollection:(DLPhotoCollection *)assetCollection;
{
    return YES;
}

- (BOOL)pickerController:(DLPhotoPickerViewController *)picker shouldEnableAsset:(DLPhotoAsset *)asset
{
    return YES;
}

- (BOOL)pickerController:(DLPhotoPickerViewController *)picker shouldSelectAsset:(DLPhotoAsset *)asset
{
    if (asset.mediaType != DLPhotoMediaTypeImage) {
        [VSAlertView ShowInView:picker.view Title:@"提示" message:@"只能上传照片" buttonTitles:@[@"知道了"] callBlock:^(NSInteger buttonIndex) {
            
        }];
        return NO;
    }
    
    
    NSInteger max = 3;
    
    if (picker.selectedAssets.count >= max){
        [VSAlertView ShowInView:picker.view Title:@"提示" message:[NSString stringWithFormat:@"您最多只能选择%ld张照片", (long)max] buttonTitles:@[@"知道了"] callBlock:^(NSInteger buttonIndex) {
            
        }];
    }
    
    // limit selection to max
    return (picker.selectedAssets.count < max);
    
    return YES;
}

- (void)pickerController:(DLPhotoPickerViewController *)picker didSelectAsset:(DLPhotoAsset *)asset
{
    // didSelectAsset
}

- (BOOL)pickerController:(DLPhotoPickerViewController *)picker shouldDeselectAsset:(DLPhotoAsset *)asset
{
    return YES;
}

- (void)pickerController:(DLPhotoPickerViewController *)picker didDeselectAsset:(DLPhotoAsset *)asset
{
    // didDeselectAsset
}

- (BOOL)pickerController:(DLPhotoPickerViewController *)picker shouldHighlightAsset:(DLPhotoAsset *)asset
{
    return YES;
}

- (void)pickerController:(DLPhotoPickerViewController *)picker didHighlightAsset:(DLPhotoAsset *)asset
{
    //  didHighlightAsset
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
    btn.frame = CGRectMake(0, idx*35, FIT6(350), 30);
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
    btn.frame = CGRectMake(0, idx*35, FIT6(350), 30);
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
