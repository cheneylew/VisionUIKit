//
//  NVDataModel.m
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVDataModel.h"

@implementation NVDataModel
@synthesize cellHeight = _cellHeight;
@synthesize cellType = _cellType;
@synthesize cellClass = _cellClass;
@synthesize actionClass = _actionClass;
@synthesize delegate = _delegate;
@synthesize cellInstance = _cellInstance;

- (id) initWithDictionary:(NSDictionary *)dictionary {
    if (dictionary == nil || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.content = @"";
    }
    return self;
}

- (NSDictionary*) dictionaryValue {
    return [NSDictionary dictionary];
}



@end



@implementation NVListModel

- (id) initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray*) items {
    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }
    
    return _items;
}

- (NSArray*) arrayValue {
    return [NSArray array];
}

@end


