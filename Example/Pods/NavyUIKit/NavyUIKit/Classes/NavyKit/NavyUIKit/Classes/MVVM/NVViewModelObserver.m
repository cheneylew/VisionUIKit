//
//  NVViewModelObserver.m
//  Navy
//
//  Created by Steven.Lin on 13/10/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//



#import "NVViewModelObserver.h"
#import "NVViewModel.h"
#import "NSDictionary+Category.h"



@interface NVViewModelObserver ()
@property (nonatomic, strong) NSMutableDictionary* dictObserved;
@end


@implementation NVViewModelObserver
IMP_SINGLETON

- (id) init {
    self = [super init];
    if (self) {
        self.dictObserved       = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) attachObservedObject:(NSObject *)object
                   forKeyPath:(NSString *)keyPath
                        event:(void (^)(NSObject *))eventBlock {
    
    NVViewModel* dataModel          = [[NVViewModel alloc] init];
    dataModel.name                  = [NSString stringWithFormat:@"%@+%@", object, keyPath];
    dataModel.dataModel             = object;
    dataModel.eventBlock            = eventBlock;
    
    [self.dictObserved setObject:dataModel forKey:dataModel.name];
    
    [object addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionOld
                context:nil];
}

- (void) detachObservedObject:(NSObject *)object
                   forKeyPath:(NSString *)keyPath {
    
    NSString* name                  = [NSString stringWithFormat:@"%@+%@", object, keyPath];
    NVViewModel* dataModel          = [self.dictObserved nvObjectForKey:name];
    if ([dataModel isKindOfClass:[NVViewModel class]]) {
        [dataModel.dataModel removeObserver:self forKeyPath:keyPath];
    }

    [self.dictObserved removeObjectForKey:name];
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary<NSString *,id> *)change
                        context:(void *)context {
    
    NSString* name                  = [NSString stringWithFormat:@"%@+%@", object, keyPath];
    NVViewModel* dataModel          = [self.dictObserved nvObjectForKey:name];
    if (dataModel &&
        dataModel.eventBlock) {
        dataModel.eventBlock(dataModel.dataModel);
    }
}

@end



