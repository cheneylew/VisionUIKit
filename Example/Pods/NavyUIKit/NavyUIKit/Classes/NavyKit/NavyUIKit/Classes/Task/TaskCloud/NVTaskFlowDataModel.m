//
//  NVTaskFlowDataModel.m
//  Navy
//
//  Created by Steven.Lin on 26/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVTaskFlowDataModel.h"



@implementation NVTaskFlowDataModel

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            self.name               = [dictionary nvObjectForKey:@"name"];
            self.flowUrl            = [dictionary nvObjectForKey:@"url"];
        }
    }
    
    return self;
}

- (NSDictionary*) dictionaryValue {
    return @{@"name": self.name,
             @"url": self.flowUrl};
}

@end



@implementation NVTaskFlowListModel

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            self.version            = [dictionary nvObjectForKey:@"version"];
            self.queryDateTime      = [dictionary nvObjectForKey:@"queryDateTime"];
            NSArray* array          = [dictionary nvObjectForKey:@"list"];
            if ([array isKindOfClass:[NSArray class]]) {
                for (NSDictionary* dict in array) {
                    NVTaskFlowDataModel* dataModel      = [[NVTaskFlowDataModel alloc] initWithDictionary:dict];
                    [self.items addObject:dataModel];
                }
            }
        }
    }
    
    return self;
}


- (NSDictionary*) dictionaryValue {
    NSMutableArray* array   = [NSMutableArray array];
    @autoreleasepool {
        [self.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NVTaskFlowDataModel* item   = (NVTaskFlowDataModel*)obj;
            [array addObject:[item dictionaryValue]];
        }];
    }
    
    return @{@"version": self.version,
             @"queryDateTime" : self.queryDateTime,
             @"list": array};
}

- (NVTaskFlowDataModel*) taskFlowByName:(NSString *)name {
    __block NVTaskFlowDataModel* dataModel = nil;
    [self.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVTaskFlowDataModel* item = (NVTaskFlowDataModel*)obj;
        if ([item.name isEqualToString:name]) {
            dataModel = item;
        }
    }];

    return dataModel;
}


@end



