//
//  XCSheetTableViewCell.m
//  xiaochunlaile
//
//  Created by Steven.Lin on 3/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "XCSheetTableViewCell.h"
#import "NVSheetTableViewCell.h"
#import "NVSheetView.h"


@interface XCSheetTableViewCell ()
@property (nonatomic, strong) NVSheetView* uiSheetView;
@end


#define CELL_HEIGHT     BASE_CELL_HEIGHT


@implementation XCSheetTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.uiSheetView    = [[NVSheetView alloc] initWithFrame:CGRectMake(30.0f,
                                                                            0.0f,
                                                                            APPLICATIONWIDTH - 60.0f,
                                                                            20.0f)];
        [self.contentView addSubview:self.uiSheetView];
        
    }
    
    return self;
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    NVSheetDataModel* dataModel     = (NVSheetDataModel*)self.item;
    
    self.uiSheetView.title          = dataModel.title;
    self.uiSheetView.value          = dataModel.value;
    if (dataModel.valueColor) {
        self.uiSheetView.valueColor = dataModel.valueColor;
    }
    
    
}


+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    NVSheetDataModel* dataModel     = (NVSheetDataModel*)object;
    
    __block CGFloat height = 0.0f;
    NVSheetView* sheetView  = [[NVSheetView alloc] initWithFrame:CGRectMake(0.0f,
                                                                            0.0f,
                                                                            APPLICATIONWIDTH - 60.0f,
                                                                            20.0f)];
    sheetView.title             = dataModel.title;
    sheetView.value             = dataModel.value;
    height += sheetView.frame.size.height;

    return height;
}

@end





@interface XCMultiSheetTableViewCell ()
@property (nonatomic, strong) NSMutableArray* arraySubviews;
@end


@implementation XCMultiSheetTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return self;
}

- (NSMutableArray*) arraySubviews {
    if (_arraySubviews == nil) {
        _arraySubviews = [NSMutableArray array];
    }
    return _arraySubviews;
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    [self.arraySubviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [(UIView*)obj removeFromSuperview];
        } else if ([obj isKindOfClass:[CALayer class]]) {
            [(CALayer*)obj removeFromSuperlayer];
        }
        
    }];
    [self.arraySubviews removeAllObjects];
    
    
    
    NVListModel* listModel      = (NVListModel*)self.item;
    
    __block CGFloat y       = 0.0f;
    [listModel.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSheetDataModel* item  = (NVSheetDataModel*)obj;
        
        NVSheetView* sheetView  = [[NVSheetView alloc] initWithFrame:CGRectMake(30.0f,
                                                                                y,
                                                                                APPLICATIONWIDTH - 60.0f,
                                                                                20.0f)];
        [self.contentView addSubview:sheetView];
        [self.arraySubviews addObject:sheetView];
        sheetView.title             = item.title;
        sheetView.value             = item.value;
        sheetView.valueColor        = item.valueColor;
        y += sheetView.frame.size.height;
        
        if (idx < [listModel.items count] - 1) {
            CALayer* line                   = [CALayer layer];
            [self.contentView.layer addSublayer:line];
            [self.arraySubviews addObject:line];
            line.frame                      = CGRectMake(30.0f, y, APPLICATIONWIDTH - 60.0f, 0.5f);
            line.backgroundColor            = COLOR_LINE.CGColor;
        }
        
    }];
    
}


+ (CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    NVListModel* listModel      = (NVListModel*)object;
    
    __block CGFloat height = 0.0f;
    [listModel.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSheetDataModel* item  = (NVSheetDataModel*)obj;
        
        NVSheetView* sheetView  = [[NVSheetView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                0.0f,
                                                                                APPLICATIONWIDTH - 60.0f,
                                                                                20.0f)];
        sheetView.title             = item.title;
        sheetView.value             = item.value;
        height += sheetView.frame.size.height;
    }];
    
    return height;
}

@end




