//
//  NVTaskFlowDataModel.h
//  Navy
//
//  Created by Steven.Lin on 26/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "Macros.h"
#import "NVDataModel.h"
#import "NVSerializedObjectProtocol.h"


@interface NVTaskFlowDataModel : NSObject
<NVFundationSerializedObjectProtocol,
NVFundationDeserializedObjectProtocol>
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* flowUrl;
@end


@interface NVTaskFlowListModel : NVListModel
<NVFundationSerializedObjectProtocol,
NVFundationDeserializedObjectProtocol>
@property (nonatomic, strong) NSString* version;
@property (nonatomic, strong) NSString* queryDateTime;
- (NVTaskFlowDataModel*) taskFlowByName:(NSString*)name;
@end
