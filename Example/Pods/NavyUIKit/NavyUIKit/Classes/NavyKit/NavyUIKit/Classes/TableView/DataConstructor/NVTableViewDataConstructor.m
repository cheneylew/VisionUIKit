//
//  NVTableViewDataConstructor.m
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewDataConstructor.h"
#import "NVTableViewCell.h"
#import <objc/runtime.h>


@implementation NVTableViewDataConstructor

- (id) init {
    self = [super init];
    if (self) {
        _indexOfHighlight = -1;
    }
    
    return self;
}

- (void) constructData {
    
}

- (void) updateHighlightCell:(CGPoint)offset {
    
}

- (NVDataModel*) itemByCellType:(NSString *)cellType {
    if ([cellType length] == 0) {
        return nil;
    }
    
    for (NSArray* array in self.items.arrayIndexPath) {
        for (NVDataModel* item in array) {
            if ([item.cellType isEqualToString:cellType]) {
                return item;
            }
        }
    }
    
    return nil;
}

- (void) indexPathByCellType:(NSString *)cellType block:(void (^)(NSIndexPath *))block {
    if ([cellType length] == 0) {
        return;
    }
    
    __block BOOL found = NO;
    [self.items.arrayIndexPath enumerateObjectsUsingBlock:^(id obj, NSUInteger section, BOOL *stop) {
        NSArray* array = (NSArray*)obj;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger row, BOOL *stop) {
            NVDataModel* item = (NVDataModel*)obj;
            if ([item.cellType isEqualToString:cellType]) {
                
                if (block) {
                    block([NSIndexPath indexPathForRow:row inSection:section]);
                }
                found = YES;
            }
            *stop = found;
        }];
        *stop = found;
    }];
}


- (void) refreshValueForCellType:(NSString *)cellType {
    NVDataModel* item = [self itemByCellType:cellType];
    if (item == nil) {
        return;
    }
    
    NVTableViewCell* cellInstance = (NVTableViewCell*)item.cellInstance;
    [cellInstance setObject:item];
}

- (void) refreshValueForCellType:(NSString *)cellType block:(void (^)(NVDataModel *))block {
    NVDataModel* item = [self itemByCellType:cellType];
    if (item == nil) {
        return;
    }
    
    if (block) {
        block(item);
        
        NVTableViewCell* cellInstance = (NVTableViewCell*)item.cellInstance;
        [cellInstance setObject:item];
    }
}


#pragma mark - setter/getter
- (NVIndexPathArray *) items {
    if (_items == nil) {
        _items = [[NVIndexPathArray alloc] init];
    }
    return _items;
}



@end



static char kAdapterArrayKeysObjectKey;


@implementation NVTableViewDataConstructor (Index)
@dynamic arrayKeys;


- (NSArray*) arrayKeys {
    return (NSArray *)objc_getAssociatedObject(self, &kAdapterArrayKeysObjectKey);
}

- (void) setArrayKeys:(NSArray *)arrayKeys {
    objc_setAssociatedObject(self, &kAdapterArrayKeysObjectKey, arrayKeys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void) constructIndex {
    
}

@end


