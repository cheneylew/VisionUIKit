//
//  NVIndexPathArray.h
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>


@interface NVIndexPathArray : NSObject
@property (nonatomic, strong, readonly) NSMutableArray* arrayIndexPath;
@property (nonatomic, strong) NSMutableArray* item;

- (void) addObject:(id)object;
- (void) addObjects:(NSArray*)array;
- (void) addObjectsAtNewSection:(NSArray *)array;
- (void) addObjects:(NSArray *)array inSection:(NSInteger)section;

- (void) removeAllObjects;
- (void) removeObjectAtIndex:(NSUInteger)index;
- (void) removeLastObject;

- (NSUInteger) count;
- (NSUInteger) countAtSection:(NSInteger)section;

- (id) objectAtIndexPath:(NSIndexPath*)indexPath;
- (NSArray*) arrayInSection:(NSInteger)section;

@end




@interface NVIndexPathArray (NVTableViewCell)
- (void) addObject:(id)object beforeCellType:(NSString*)cellType;
- (void) addObject:(id)object afterCellType:(NSString *)cellType;
- (void) removeObjectByCellType:(NSString*)cellType;
@end

