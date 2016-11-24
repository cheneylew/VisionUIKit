//
//  NVJavaScriptObserver.m
//  Navy
//
//  Created by Steven.Lin on 11/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVJavaScriptObserver.h"
#import "NVJsObservedObject.h"


@interface NVJavaScriptObserver ()
@property (nonatomic, strong) NSMutableDictionary* dictObserver;
@end


@implementation NVJavaScriptObserver

IMP_SINGLETON

- (instancetype) init {
    self = [super init];
    if (self) {
        
        self.dictObserver           = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void) addObserverName:(NSString *)name
                  jsName:(NSString *)jsName
                  invoke:(void (^)(NSString*, NSArray *, UIViewController *))block {
    
    NVJsObservedObject* object  = [[NVJsObservedObject alloc] init];
    object.name                 = name;
    object.jsName               = jsName;
    object.invokeBlock          = block;
    
    [self.dictObserver setObject:object forKey:name];
}

- (NSDictionary*) observer {
    return self.dictObserver;
}

@end

