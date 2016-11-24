//
//  NVTableViewDataConstructor.h
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVDataModel.h"
#import "NVIndexPathArray.h"



@interface NVTableViewDataConstructor : NSObject
@property (nonatomic, strong) NVIndexPathArray * items;
@property (nonatomic, assign) NSInteger indexOfHighlight;
@property (nonatomic, assign) UIViewController* viewControllerDelegate;


- (void) constructData;
- (void) constructData:(void (^)(NSString *, NVDataModel *))reactBlock before:(void(^)(void))beforeBlock;

- (void) updateHighlightCell:(CGPoint)offset;
- (NVDataModel*) itemByCellType:(NSString*)cellType;
- (id) valueForCellType:(NSString*)cellType;

- (void) indexPathByCellType:(NSString*)cellType block:(void (^)(NSIndexPath* indexPath))block;

- (void) refreshValueForCellType:(NSString*)cellType;
- (void) refreshValueForCellType:(NSString *)cellType block:(void (^)(NVDataModel* item))block;

@end



@interface NVTableViewDataConstructor (Index)
@property (nonatomic, strong) NSArray* arrayKeys;
- (void) constructIndex;
@end

