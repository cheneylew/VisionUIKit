//
//  NVMenuView.h
//  Navy
//
//  Created by Jelly on 6/29/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVMenuItemView.h"


@protocol NVMenuViewDataSource;
@protocol NVMenuViewDelegate;


@interface NVMenuView : UIView
@property (nonatomic, assign) id<NVMenuViewDelegate> delegate;
@property (nonatomic, assign) id<NVMenuViewDataSource> dataSource;
@property (nonatomic, assign) NSUInteger indexOfSelection;
@property (nonatomic, assign) NSUInteger count;

- (void) reloadData;

- (void) reloadData:(NSUInteger(^)(void))numberOfItems
             height:(CGFloat(^)(NSIndexPath* indexPath))heightOfItem
               item:(NVMenuItemView*(^)(NSIndexPath* indexPath))item;

- (void) reloadDataWithTitles:(NSArray *(^)(void))titleOfItems;
- (void) reloadDataWithTitles:(NSArray *(^)(void))titleOfItems itemViewInstance:(NVMenuItemView*(^)(NSUInteger index))viewOfItem;
- (NVMenuItemView*)itemAtIndex:(NSInteger)index;
@end



@protocol NVMenuViewDataSource <NSObject>
- (NSUInteger) numberOfItemsAtRow:(NSUInteger)row inMenuView:(NVMenuView*)menuView;
- (NVMenuItemView*) itemAtIndexPath:(NSIndexPath*)indexPath inMenuView:(NVMenuView*)menuView;
- (CGFloat) heightOfItemAtIndexPath:(NSIndexPath*)indexPath inMenuView:(NVMenuView*)menuView;
@end


@protocol NVMenuViewDelegate <NSObject>
- (void) menuView:(NVMenuView*)view didSelectionIndex:(NSUInteger)index;
@end



@interface NVMenuScrollView : NVMenuView
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, assign) CGFloat interSpacing;
@end


