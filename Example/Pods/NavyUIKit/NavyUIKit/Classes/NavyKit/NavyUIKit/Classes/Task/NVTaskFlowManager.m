//
//  NVTaskFlowManager.m
//  Navy
//
//  Created by Steven.Lin on 4/2/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVTaskFlowManager.h"
#import "NSString+Category.h"
#import "NSDictionary+Category.h"


@interface NVFlowURLDataModel : NSObject
@property (nonatomic, strong) NSString* schemaName;
@property (nonatomic, strong) NSString* serviceName;
@property (nonatomic, strong) NSString* parametersPath;
@end


@implementation NVFlowURLDataModel

@end




@interface NVTaskFlowManager ()
@property (nonatomic, strong) NSMutableDictionary* dictTaskFlow;
@property (nonatomic, strong) NSString* appSchema;
@end



@implementation NVTaskFlowManager

IMP_SINGLETON

- (NSMutableDictionary*) dictTaskFlow {
    if (_dictTaskFlow == nil) {
        _dictTaskFlow = [[NSMutableDictionary alloc] init];
    }
    
    return _dictTaskFlow;
}


- (void) setLocalAppSchema:(NSString *)appSchema {
    _appSchema = appSchema;
}


- (void) registerLocalTaskFlowWithSchemaName:(NSString *)schemaName
                                 serviceName:(NSString *)serviceName
                              parametersPath:(NSString *)parametersPath {
    if ([schemaName length] == 0 ||
        [serviceName length] == 0 ||
        [parametersPath length] == 0) {
        return;
    }
    
    NVFlowURLDataModel* item        = [[NVFlowURLDataModel alloc] init];
    item.schemaName                 = schemaName;
    item.serviceName                = serviceName;
    item.parametersPath             = parametersPath;
    [self.dictTaskFlow setObject:item forKey:schemaName];
}


- (NSURL*) generateLocalTaskFlowWithSchemaName:(NSString *)schemaName
                              parametersObject:(id<NVTaskFlowParametersObjectProtocol>)parametersObject {
    if ([schemaName length] == 0) {
        return nil;
    }
    
    
    
    
    NVFlowURLDataModel* itemFlowUrl = [self.dictTaskFlow objectForKey:schemaName];
    if (itemFlowUrl == nil) {
        return nil;
    }
    
    __block NSString* parametersPath        = itemFlowUrl.parametersPath;
    NSArray* arrayParameters        = [parametersPath parametersSorted];
    [arrayParameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* keyValue      = (NSDictionary*)obj;
        NSString* key               = [[keyValue allKeys] objectAtIndex:0];
        NSString* variableVar       = [keyValue nvObjectForKey:key];
        
        NSString* const VARIABLEVAR = @"%[a-zA-Z0-9]+%";
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VARIABLEVAR];
        if ([predicate evaluateWithObject:variableVar]) {
            
            if (![parametersObject respondsToSelector:@selector(valueForParameterKey:)]) {
                NSLog(@"##ERROR## %@ NO responds valueForParameterKey:", NSStringFromClass([parametersObject class]));
            }
            
            NSString* value = [parametersObject valueForParameterKey:variableVar];
            if ([value length] > 0) {
                parametersPath = [parametersPath stringByReplacingOccurrencesOfString:variableVar withString:value];
            }
        }
        
    }];
    
    NSString* urlString     = [NSString stringWithFormat:@"%@://Service%@?%@", self.appSchema, itemFlowUrl.serviceName, parametersPath];
    NSString* urlEncode     = [urlString URLEncodedChineseString];
    NSURL* url              = [NSURL URLWithString:urlEncode];
    
    return url;
}



@end



