//
//  NVImageBrowserTableViewCell.h
//  Fanyue.iOS
//
//  Created by linguodong on 2/2/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewLineCell.h"


@interface NVImageBrowserDataModel : NVLineDataModel
@property (nonatomic, strong) NSMutableArray* imageNameds;
@property (nonatomic, strong) NSMutableArray* titles;
@end



@protocol NVImageBrowserTableViewCellDelegate;

@interface NVImageBrowserTableViewCell : NVTableViewLineCell
@property (nonatomic, assign) id<NVImageBrowserTableViewCellDelegate> delegate;
@end

@protocol NVImageBrowserTableViewCellDelegate <NSObject>
- (void) imageBrowserTableViewCell:(NVImageBrowserTableViewCell*)cell didClickImagePath:(NSString*)imagePath;
@end


