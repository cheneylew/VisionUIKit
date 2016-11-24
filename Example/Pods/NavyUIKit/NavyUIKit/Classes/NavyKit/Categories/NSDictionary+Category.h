//
//  NSDictionary+Category.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

//用于数据解析，返回对象为字符串或值类型，数组和字典不要用此方法
- (id)nvObjectForKey:(NSString *)key;

//设置键值对 针对对象为空处理
- (void)nvSetObject:(id)object forKey:(id)key;
- (id)objectForKeyCustom:(id)aKey;

- (id)nvKeyForValue:(id)value;
@end


