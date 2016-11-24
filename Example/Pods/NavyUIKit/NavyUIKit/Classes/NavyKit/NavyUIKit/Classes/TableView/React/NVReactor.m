//
//  NVReactor.m
//  Navy
//
//  Created by Steven.Lin on 19/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVReactor.h"
#import "NVViewModelObserver.h"
#import "NSDictionary+Category.h"


@interface NVReactor ()
@property (nonatomic, strong) NSMutableArray* arrayItems;
@end



@implementation NVReactor


- (NSMutableArray*) arrayItems {
    if (_arrayItems == nil) {
        _arrayItems = [[NSMutableArray alloc] init];
    }
    
    return _arrayItems;
}

- (void) registerObservedObject:(NVDataModel *)dataModel
                 objectIdentity:(NSString *)identity
                     forKeyPath:(NSString *)keyPath
                          block:(void (^)(NSObject *))eventBlock {
    
    [[NVViewModelObserver sharedInstance] attachObservedObject:dataModel
                                                    forKeyPath:keyPath
                                                         event:eventBlock];
    
    NSDictionary* dictionary        = @{@"object": dataModel,
                                        @"identity": identity,
                                        @"keyPath": keyPath};
    
    [self.arrayItems addObject:dictionary];
    
}

- (void) unregisterObservedObjectForIdentity:(NSString *)identity {
    
    [self.arrayItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* dictionary    = (NSDictionary*)obj;
        id dataModel                = [dictionary nvObjectForKey:@"object"];
        NSString* keyPath           = [dictionary nvObjectForKey:@"keyPath"];
        NSString* identity1         = [dictionary nvObjectForKey:@"identity"];
        
        if ([identity isEqualToString:identity1]) {
            [[NVViewModelObserver sharedInstance] detachObservedObject:dataModel forKeyPath:keyPath];
            [self.arrayItems removeObject:dictionary];
            *stop = YES;
        }
        
    }];
    
}

- (void) unregisterAllObservedObjects {
    [self.arrayItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* dictionary    = (NSDictionary*)obj;
        id dataModel                = [dictionary nvObjectForKey:@"object"];
        NSString* keyPath           = [dictionary nvObjectForKey:@"keyPath"];
        
        [[NVViewModelObserver sharedInstance] detachObservedObject:dataModel forKeyPath:keyPath];
    }];
    
    [self.arrayItems removeAllObjects];
}

@end



