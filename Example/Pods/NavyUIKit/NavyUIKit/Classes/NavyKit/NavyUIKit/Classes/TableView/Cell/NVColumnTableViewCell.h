//
//  NVColumnTableViewCell.h
//  Navy
//
//  Created by Steven.Lin on 23/3/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"



@interface NVColumnDataModel : NVDataModel
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* imageNamed;
@property (nonatomic, strong) UIImage* image;
@end

@interface NVColumnListModel : NVListModel

@end



@protocol NVColumnTableViewCellDelegate;

@interface NVColumnTableViewCell : NVTableViewNullCell
@property (nonatomic, assign) id<NVColumnTableViewCellDelegate> delegate;
@end


@protocol NVColumnTableViewCellDelegate <NSObject>
- (void) columnTableViewCell:(NVColumnTableViewCell*)cell didClickItem:(NVColumnDataModel*)item;
@end

