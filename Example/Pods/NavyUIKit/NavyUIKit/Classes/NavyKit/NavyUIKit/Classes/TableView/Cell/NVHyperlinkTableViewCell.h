//
//  NVHyperlinkTableViewCell.h
//  Navy
//
//  Created by Jelly on 7/12/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewNullCell.h"
#import "NVHyperlinkLabel.h"



@interface NVHyperlinkItemDataModel : NVDataModel
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* urlPath;
@property (nonatomic, strong) UIColor* colorText;
@property (nonatomic, strong) UIColor* colorLink;
@end


@interface NVHyperlinkDataModel : NVListModel
@property (nonatomic, assign) NSTextAlignment textAlignment;
@end




@protocol NVHyperlinkTableViewCellDelegate;


@interface NVHyperlinkTableViewCell : NVTableViewNullCell
@property (nonatomic, assign) id<NVHyperlinkTableViewCellDelegate> delegate;
@end


@protocol NVHyperlinkTableViewCellDelegate <NSObject>
- (void) hyperlinkTableViewCell:(NVHyperlinkTableViewCell*)cell didClickUrlPath:(NSString*)urlPath;
@end


