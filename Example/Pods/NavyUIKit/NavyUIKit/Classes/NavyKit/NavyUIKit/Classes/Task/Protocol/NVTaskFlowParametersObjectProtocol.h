//
//  NVTaskFlowParametersObjectProtocol.h
//  Navy
//
//  Created by Steven.Lin on 5/2/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NVTaskFlowParametersObjectProtocol <NSObject>
- (NSString*) valueForParameterKey:(NSString*)key;
@end
