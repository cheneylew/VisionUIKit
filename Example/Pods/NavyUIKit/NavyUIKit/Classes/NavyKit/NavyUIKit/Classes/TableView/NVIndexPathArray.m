//
//  NVIndexPathArray.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//


#import "NVIndexPathArray.h"


@implementation NVIndexPathArray



- (id) init {
    self = [super init];
    if (self) {
        _arrayIndexPath = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) setItem:(NSMutableArray *)item {
    _arrayIndexPath = [[NSMutableArray alloc] initWithObjects:item, nil];
}

- (void) addObject:(id)object {
    if (object == nil) {
        return;
    }
    
    if ([_arrayIndexPath count] == 0) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        [_arrayIndexPath addObject:array];
    }
    
    NSMutableArray* array = [_arrayIndexPath lastObject];
    [array addObject:object];
}

- (void) addObjects:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        
        if ([_arrayIndexPath count] > 0) {
            [self addObjects:array inSection:[_arrayIndexPath count] - 1];
        } else {
            [self addObjectsAtNewSection:array];
        }
    }
}

- (void) addObjectsAtNewSection:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        NSMutableArray* newArray = [[NSMutableArray alloc] initWithArray:array];
        [_arrayIndexPath addObject:newArray];
    }
}

- (void) addObjects:(NSArray *)array inSection:(NSInteger)section {
    if ([array isKindOfClass:[NSArray class]]) {
        if (section >= 0 && section < [_arrayIndexPath count]) {
            NSMutableArray* updateArray = [[NSMutableArray alloc] initWithArray:[_arrayIndexPath objectAtIndex:section]];
            [updateArray addObjectsFromArray:array];
            [_arrayIndexPath replaceObjectAtIndex:section withObject:updateArray];
        }
    }
}

- (void) removeAllObjects {
    [_arrayIndexPath removeAllObjects];
}

- (void) removeObjectAtIndex:(NSUInteger)index{
    [_arrayIndexPath.firstObject removeObjectAtIndex:index];
}

- (void) removeLastObject{
    [_arrayIndexPath.firstObject removeLastObject];
}


- (NSUInteger) count {
    return [_arrayIndexPath count];
}

- (NSUInteger) countAtSection:(NSInteger)section {
    if (section >= 0 && section < [_arrayIndexPath count]) {
        NSArray* array = [_arrayIndexPath objectAtIndex:section];
        return [array count];
    }
    
    return 0;
}

- (id) objectAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section >= 0 && section < [_arrayIndexPath count]) {
        NSArray* array = [_arrayIndexPath objectAtIndex:section];
        if (row >= 0 && row < [array count]) {
            return [array objectAtIndex:row];
        }
    }
    
    return nil;
}

- (NSArray*) arrayInSection:(NSInteger)section {
    if (section >= 0 && section < [_arrayIndexPath count]) {
        return [_arrayIndexPath objectAtIndex:section];
    }
    
    return nil;
}

@end




#import "NVDataModel.h"

@implementation NVIndexPathArray (NVTableViewCell)

- (void) addObject:(id)object beforeCellType:(NSString *)cellType {
    [self addObject:object byCellType:cellType offsetIndex:0];
}

- (void) addObject:(id)object afterCellType:(NSString *)cellType {
    [self addObject:object byCellType:cellType offsetIndex:+1];
}

- (void) removeObjectByCellType:(NSString *)cellType {
    if ([cellType length] == 0) {
        return;
    }
    
    if ([_arrayIndexPath count] == 0) {
        return;
    }
    
    [_arrayIndexPath enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray* array   = (NSMutableArray*)obj;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NVDataModel* item   = (NVDataModel*)obj;
            if ([item.cellType isEqualToString:cellType]) {
                // remove
                
                [array removeObject:item];
                *stop = YES;
            }
        }];
    }];
}


#pragma mark - private
-  (void) addObject:(id)object byCellType:(NSString *)cellType offsetIndex:(NSInteger)offset {
    if (object == nil || [cellType length] == 0) {
        return;
    }
    
    if ([_arrayIndexPath count] == 0) {
        return;
    }
    
    [_arrayIndexPath enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray* array   = (NSMutableArray*)obj;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NVDataModel* item   = (NVDataModel*)obj;
            if ([item.cellType isEqualToString:cellType]) {
                // insert
                
                [array insertObject:object atIndex:idx+offset];
                *stop = YES;
            }
        }];
    }];
}


@end


