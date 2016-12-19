//
//  VSUserDataModel.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSUserDataModel.h"
#import <KKCategories/KKCategories.h>

@implementation VSUserDataModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        self = [super init];
        if (self) {
            self.userid     = [dictionary jk_stringForKey:@"userid"];
            self.username   = [dictionary jk_stringForKey:@"username"];
            self.deviceinfo = [dictionary jk_stringForKey:@"deviceinfo"];
            self.token      = [dictionary jk_stringForKey:@"token"];
            self.mobile     = [dictionary jk_stringForKey:@"mobile"];
            self.email      = [dictionary jk_stringForKey:@"email"];
        }
        return self;
    } else
        return nil;
}

- (NSDictionary *)dictionaryValue {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic jk_setObj:self.userid forKey:@"userid"];
    [dic jk_setObj:self.username forKey:@"username"];
    [dic jk_setObj:self.deviceinfo forKey:@"deviceinfo"];
    [dic jk_setObj:self.token forKey:@"token"];
    [dic jk_setObj:self.mobile forKey:@"mobile"];
    [dic jk_setObj:self.email forKey:@"email"];
    return dic;
}

@end

@implementation VSUserListModel

- (id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        if ([array isKindOfClass:[NSArray class]]) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    [self.items addObject:[[VSUserDataModel alloc] initWithDictionary:obj]];
                }
            }];
        }
    }
    return self;
}

@end
