//
//  NVNotificationObservers.m
//  Navy
//
//  Created by Steven.Lin on 16/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVNotificationObservers.h"
#import "NSDictionary+Category.h"
#import "NSString+Category.h"


@interface NVNotificationObservers ()
@property (nonatomic, strong) NSMutableDictionary* dictObserver;
@end


@implementation NVNotificationObservers
IMP_SINGLETON


- (id) init {
    self = [super init];
    if (self) {
        
        self.dictObserver           = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void) setServiceTag:(NSString *)serviceTag {
    _serviceTag = serviceTag;
}

- (void) setParamTag:(NSString *)paramTag {
    _paramTag = paramTag;
}

- (void) addObserverName:(NSString *)name notificationName:(NSString *)notificationName invoke:(void (^)(NSString *, NSDictionary *))block {
    NVNotifyObservedObject* object      = [[NVNotifyObservedObject alloc] init];
    object.name                         = name;
    object.notifyName                   = notificationName;
    object.invokeBlock                  = block;
    
    [self.dictObserver setObject:object forKey:notificationName];
}

- (NVNotifyObservedObject*) observedObjectForNotificationName:(NSString *)notificationName {
    return [self.dictObserver nvObjectForKey:notificationName];
}

- (NVNotifyObservedObject*) observedObjectForNotification:(NSDictionary *)notification {
    NSString* serviceName               = [notification nvObjectForKey:self.serviceTag];
    
    if ([serviceName isKindOfClass:[NSString class]] && [serviceName length] > 0) {
        NVNotifyObservedObject* object      = [self.dictObserver nvObjectForKey:serviceName];
        if ([object isKindOfClass:[NVNotifyObservedObject class]]) {
            
            NSString* params                = [notification nvObjectForKey:self.paramTag];
            if ([params isKindOfClass:[NSString class]] && [params length] > 0) {
                NSDictionary* parameters    = [params parameters];
                
                if (object.invokeBlock) {
                    object.invokeBlock(object.name, parameters);
                }
            }
            
        }
    }
    
    return nil;
}

@end
