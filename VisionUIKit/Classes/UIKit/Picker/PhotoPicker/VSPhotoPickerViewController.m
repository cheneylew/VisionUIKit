//
//  VSPhotoPickerViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/28.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSPhotoPickerViewController.h"
#import <KKCategories/KKCategories.h>
#import <DJMacros/DJMacro.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "VSPhotoCollectionViewCell.h"

@interface VSPhotoPickerViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *listData;

@end

@implementation VSPhotoPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(100, 100, 50, 50);
    
    WEAK_SELF;
    [cancelButton jk_addActionHandler:^(NSInteger tag) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:cancelButton];
    
    
    [self createCollectionView];
    [self photos];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(304, 153);
    layout.minimumInteritemSpacing = 15;
    layout.minimumLineSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(20, 25, 15, 25);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView registerClass:[VSPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    self.listData = @[];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VSPhotoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.imageView.image = [self.listData objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)photos {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];//生成整个photolibrary句柄的实例
    NSMutableArray *mediaArray = [[NSMutableArray alloc]init];//存放media的数组
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {//获取所有group
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
            NSString* assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                NSLog(@"Photo");
                UIImage *img = [UIImage imageWithCGImage:[result thumbnail]];
                [mediaArray addObject:img];
                
            }else if([assetType isEqualToString:ALAssetTypeVideo]){
                NSLog(@"Video");
            }else if([assetType isEqualToString:ALAssetTypeUnknown]){
                NSLog(@"Unknow AssetType");
            }
            
            NSDictionary *assetUrls = [result valueForProperty:ALAssetPropertyURLs];
            NSUInteger assetCounter = 0;
            for (NSString *assetURLKey in assetUrls) {
                NSLog(@"Asset URL %lu = %@",(unsigned long)assetCounter,[assetUrls objectForKey:assetURLKey]);
            }
            
            NSLog(@"Representation Size = %lld",[[result defaultRepresentation]size]);
        }];
    } failureBlock:^(NSError *error) {
        NSLog(@"Enumerate the asset groups failed.");
    }];
    
    self.listData = mediaArray;
    [self.collectionView reloadData];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    iv.backgroundColor = [UIColor blueColor];
    iv.image = self.listData.lastObject;
    [self.view addSubview:iv];
}

@end
