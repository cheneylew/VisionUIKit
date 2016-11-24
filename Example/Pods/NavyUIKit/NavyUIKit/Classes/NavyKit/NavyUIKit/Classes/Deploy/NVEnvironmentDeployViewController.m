//
//  NVEnvironmentDeployViewController.m
//  Navy
//
//  Created by Jelly on 9/16/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVEnvironmentDeployViewController.h"
#import "NVEnvironmentDeployDataConstructor.h"
#import "NVTagTableViewCell.h"
#import "NVButtonTableViewCell.h"


@interface NVEnvironmentDeployViewController ()
<NVTableViewAdaptorDelegate,
NVButtonTableViewCellDelegate>
@property (nonatomic, strong) NVEnvironmentDeployDataConstructor* dataConstructor;
@end


@implementation NVEnvironmentDeployViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor   = COLOR_HM_WHITE_GRAY;
    
    CGRect frame            = self.uiTableView.frame;
    frame.size.height       -= NAVIGATIONBARHEIGHT +20;
    
    self.uiTableView.frame = frame;
}


- (NSString*) getNavigationTitle {
    return @"环境配置";
}


- (void) constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[NVEnvironmentDeployDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
    }
    
    self.typeOfSelection = @"cell.type.env.dev1";
    self.dataConstructor.typeOfSelection = self.typeOfSelection;
    [self.dataConstructor constructData];
    self.adaptor.items = self.dataConstructor.items;
}


#pragma mark - NVTableViewAdaptorDelegate
- (void) tableView:(UITableView *)tableView didSelectObject:(id<NVTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellType = object.cellType;
    if ([cellType isEqualToString:@"cell.type.null"] ||
        [cellType isEqualToString:@"cell.type.title"] ||
        [cellType isEqualToString:@"cell.type.button"]) {
        return;
    }
    
    if ([self.typeOfSelection isEqualToString:cellType]) {
        return;
    }
    
    [self.dataConstructor refreshValueForCellType:self.typeOfSelection block:^(NVDataModel *item) {
        NVTagDataModel* dataModel = (NVTagDataModel*)item;
        dataModel.selected = NO;
    }];
    
    [self.dataConstructor refreshValueForCellType:cellType block:^(NVDataModel *item) {
        NVTagDataModel* dataModel = (NVTagDataModel*)item;
        dataModel.selected = YES;
    }];
    
    self.typeOfSelection = cellType;
    
}


#pragma mark - NVButtonTableViewCellDelegate
- (void) didClickButtonTableViewCell:(NVButtonTableViewCell *)cell {
    
    __block NSString* environment = nil;
    [self.environments enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString* keyName       = (NSString*)key;
        NSString* value         = (NSString*)obj;
        if ([keyName isEqualToString:self.typeOfSelection]) {
            environment         = value;
            *stop = YES;
        }
    }];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(environmentDeployViewController:didSelectEnvironment:)]) {
        [self.delegate environmentDeployViewController:self
                                  didSelectEnvironment:environment];
    } else {
        
    }
}

@end



