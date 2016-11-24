//
//  NVViewModelCommand.h
//  Navy
//
//  Created by Steven.Lin on 13/10/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NVViewModelCommandCompleteBlock) (id error, id content);
typedef void(^NVViewModelCommandConsumeBlock) (id value, NVViewModelCommandCompleteBlock completeHandler);
typedef void(^NVViewModelCommandCancelBlock) (void);


@interface NVViewModelCommand : NSObject
- (instancetype) initWithConsumeHandler:(NVViewModelCommandConsumeBlock)consumeHandler;
- (instancetype) initWithConsumeHandler:(NVViewModelCommandConsumeBlock)consumeHandler cancelHandler:(NVViewModelCommandCancelBlock)cancelHandler;
- (void) execute:(id)value;
- (void) cancel;
@end
