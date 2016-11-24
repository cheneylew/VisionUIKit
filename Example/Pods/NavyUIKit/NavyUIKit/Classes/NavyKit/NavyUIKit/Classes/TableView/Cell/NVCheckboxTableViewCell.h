//
//  NVCheckboxTableViewCell.h
//  Navy
//
//  Created by Jelly on 7/13/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewLineCell.h"
#import "NVHyperlinkTableViewCell.h"
#import "NVDataModel.h"


@interface NVCheckboxDataModel : NVDataModel
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UIImage* imageNormal;
@property (nonatomic, strong) UIImage* imageSelected;
@end


@protocol NVCheckboxTableViewCellDelegate;

@interface NVCheckboxTableViewCell : NVTableViewLineCell
@property (nonatomic, assign) id<NVCheckboxTableViewCellDelegate> delegate;
@end


@interface NVCheckboxTableViewCell2 : NVCheckboxTableViewCell

@end



@protocol NVCheckboxTableViewCellDelegate <NSObject>
- (void) checkboxTableViewCell:(NVCheckboxTableViewCell*)cell didChangeCheckboxState:(BOOL)state;
@end




@protocol NVHyperlinkCheckboxTableViewCellDelegate;

@interface NVHyperlinkCheckboxDataModel : NVHyperlinkDataModel
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UIImage* imageNormal;
@property (nonatomic, strong) UIImage* imageSelected;
@end


@interface NVHyperlinkCheckboxTableViewCell : NVCheckboxTableViewCell2
@property (nonatomic, assign) id<NVHyperlinkCheckboxTableViewCellDelegate> delegate;
@end


@protocol NVHyperlinkCheckboxTableViewCellDelegate <NVCheckboxTableViewCellDelegate>
- (void) hyperlinkCheckboxTableViewCell:(NVHyperlinkCheckboxTableViewCell*)cell touchUrl:(NSString*)urlPath;
@end

