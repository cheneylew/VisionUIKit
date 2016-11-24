//
//  NVTableViewAdaptor.h
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVTableView.h"
#import "NVTableViewCell.h"
#import "NVIndexPathArray.h"
#import "NVTableViewCellItemProtocol.h"


@protocol NVTableViewAdaptorDelegate;

@interface NVTableViewAdaptor : NSObject
<NVTableViewDataSource,
UITableViewDelegate>

@property (nonatomic, assign) NVTableView* uiTableView;
@property (nonatomic, strong) NVIndexPathArray* items;
@property (nonatomic, assign) id<NVTableViewAdaptorDelegate> delegate;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) BOOL canMove;


- (NVTableViewCell *) generateCellForObject:(id<NVTableViewCellItemProtocol>)object
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifier;

- (NSString*) tableViewClassName;

- (void)tableViewDidScroll:(UITableView *)tableView;
- (void)tableViewDidEndDragging:(UITableView *)tableView;
- (void)tableViewWillBeginDragging:(UITableView *)tableView;
@end


@protocol NVTableViewAdaptorDelegate <NSObject>

- (void) tableView:(UITableView *)tableView didSelectObject:(id<NVTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (BOOL) tableView:(UITableView *)tableView enableGroupModeAtSection:(NSInteger)section;
- (BOOL) tableView:(UITableView *)tableView canEditObject:(id<NVTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL) tableView:(UITableView *)tableView canMoveObject:(id<NVTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) tableView:(UITableView *)tableView commitDeletingObject:(id<NVTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell withObject:(id<NVTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewDidScroll:(UITableView *)tableView;
- (void)tableViewWillBeginDragging:(UITableView *)tableView;
- (void)tableViewDidEndDragging:(UITableView *)tableView;
- (void)tableViewScrollBottom:(UITableView*)tableView;

@end



@interface NVTableViewAdaptor (Index)
@property (nonatomic, strong) NSArray* arrayKeys;
@property (nonatomic, copy) Class headerClass;
@end



@interface NVTableViewAdaptor (Footer)
@property (nonatomic, strong) NSArray* footerItems;
@end



