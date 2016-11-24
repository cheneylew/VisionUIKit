//
//  NVMenuView.m
//  Navy
//
//  Created by Jelly on 6/29/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVMenuView.h"
#import "Macros.h"

@interface NVMenuView ()
@property (nonatomic, strong) NSMutableArray* arrayButtonItems;
- (void) buttonAction:(id)sender;
@end


@implementation NVMenuView


- (NSMutableArray*) arrayButtonItems {
    if (_arrayButtonItems == nil) {
        _arrayButtonItems = [[NSMutableArray alloc] init];
    }
    
    return _arrayButtonItems;
}


- (void) reloadData {
    [self.arrayButtonItems removeAllObjects];
    
    NSUInteger row = 0;
    if (self.dataSource
        && [self.dataSource respondsToSelector:@selector(numberOfItemsAtRow:inMenuView:)]) {
        
        NSUInteger count = [self.dataSource numberOfItemsAtRow:row inMenuView:self];
        if (count == 0) {
            return;
        }
        
        if (self.dataSource
            && [self.dataSource respondsToSelector:@selector(itemAtIndexPath:inMenuView:)]) {
            
            CGSize size = self.bounds.size;
            CGFloat x = 0.0f;
            CGFloat y = 0.0f;
            CGFloat width = size.width / count;
            CGFloat height = size.height;
            for (NSUInteger i = 0; i < count; i++) {
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:row];
                
                NVMenuItemView* itemView = [self.dataSource itemAtIndexPath:indexPath inMenuView:self];
                [self addSubview:itemView];
                [self.arrayButtonItems addObject:itemView];
                itemView.exclusiveTouch = YES;
                
                if ([self.dataSource respondsToSelector:@selector(heightOfItemAtIndexPath:inMenuView:)]) {
                    height  = [self.dataSource heightOfItemAtIndexPath:indexPath inMenuView:self];
                    y       = (size.height - height) / 2;
                }
                itemView.frame = CGRectMake(x, y, width, height);
                x += width;
                
            }
        }
        
    }
}


- (void) reloadDataWithTitles:(NSArray *(^)(void))titleOfItems {
    
    [self reloadDataWithTitles:titleOfItems
              itemViewInstance:^NVMenuItemView *(NSUInteger index) {
                  return [[NVMenuItemView alloc] init];
              }];
    
}

- (void) reloadDataWithTitles:(NSArray *(^)(void))titleOfItems itemViewInstance:(NVMenuItemView *(^)(NSUInteger))viewOfItem {
    
    if (titleOfItems == nil) {
        return;
    }
    
    [self.arrayButtonItems removeAllObjects];
    
    NSArray* arrayTitles = titleOfItems();
    if ([arrayTitles isKindOfClass:[NSArray class]]) {
        
        CGFloat width = self.frame.size.width / [arrayTitles count];
        CGFloat height = self.frame.size.height;
        [arrayTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* title = (NSString*)obj;
            
            NVMenuItemView* itemView = nil;
            if (viewOfItem) {
                itemView = viewOfItem(idx);
            } else {
                itemView = [[NVMenuItemView alloc] init];
            }
            [self addSubview:itemView];
            [self.arrayButtonItems addObject:itemView];
            
            [itemView setFrame:CGRectMake(width * idx, 0.0f, width, height)];
            [itemView setTitle:title forState:UIControlStateNormal];
            [itemView addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            itemView.tag = idx;
            
            itemView.exclusiveTouch = YES;
            
        }];
        
        [self setNeedsLayout];
    }
    
}

- (NVMenuItemView*)itemAtIndex:(NSInteger)index {
    NVMenuItemView* item = (NVMenuItemView*)[self.arrayButtonItems objectAtIndex:index];
    return item;
}

- (void) setIndexOfSelection:(NSUInteger)indexOfSelection {
    _indexOfSelection = indexOfSelection;
    
    if ([self.arrayButtonItems count] <= indexOfSelection) {
        return;
    }
    
    [self.arrayButtonItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NVMenuItemView* view = (NVMenuItemView*)obj;
        view.selected = _indexOfSelection == idx;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuView:didSelectionIndex:)]) {
        [self.delegate menuView:self didSelectionIndex:self.indexOfSelection];
    }
}

- (NSUInteger) count {
    return [self.arrayButtonItems count];
}

- (void) buttonAction:(id)sender {
    
    NVMenuItemView* view = (NVMenuItemView*)sender;
    self.indexOfSelection = view.tag;

}

@end






@implementation NVMenuScrollView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor        = COLOR_DEFAULT_WHITE;
        
        self.scrollView             = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                     0.0f,
                                                                                     frame.size.width,
                                                                                     frame.size.height)];
        [self addSubview:self.scrollView];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;

    }
    
    return self;
}

- (void) reloadDataWithTitles:(NSArray *(^)(void))titleOfItems itemViewInstance:(NVMenuItemView *(^)(NSUInteger))viewOfItem {
    
    if (titleOfItems == nil) {
        return;
    }
    
    [self.arrayButtonItems removeAllObjects];
    
    NSArray* arrayTitles = titleOfItems();
    if ([arrayTitles isKindOfClass:[NSArray class]]) {
        
//        CGFloat width = self.frame.size.width / 4;
        __block CGFloat x = self.interSpacing;
        CGFloat height = self.frame.size.height;
        [arrayTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* title = (NSString*)obj;
            
            NVMenuItemView* itemView = nil;
            if (viewOfItem) {
                itemView = viewOfItem(idx);
            } else {
                itemView = [[NVMenuItemView alloc] init];
            }
            [self.scrollView addSubview:itemView];
            [self.arrayButtonItems addObject:itemView];
            
            [itemView setTitle:title forState:UIControlStateNormal];
            CGFloat width = (APPLICATIONWIDTH-(arrayTitles.count+1)*self.interSpacing)/arrayTitles.count;
            
            [itemView setFrame:CGRectMake(x, 0.0f, width, height)];
            [itemView addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            itemView.tag = idx;
            itemView.exclusiveTouch = YES;
            
            x += width + self.interSpacing;
        }];
        
        self.scrollView.contentSize = CGSizeMake(x, self.frame.size.height);
        if (x < self.bounds.size.width) {
            NSInteger count = [self.arrayButtonItems count];
            dispatch_apply(count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0L), ^(size_t index) {
                NVMenuItemView* view = [self.arrayButtonItems objectAtIndex:index];
                
                CGFloat width   = self.bounds.size.width / count;
                CGRect frame    = view.frame;
                frame.origin.x  = width * index + (width - frame.size.width)/2;
                dispatch_async(dispatch_get_main_queue(), ^{
                    view.frame  = frame;
                    
                    if (index == 0) {
                        [self setNeedsLayout];
                    }
                });
            });
            
        }
        
    }
    
}


@end

