//
//  SorterManager.h
//  Test
//
//  Created by Dejun Liu on 2017/1/23.
//  Copyright © 2017年 xiaolu zhao. All rights reserved.
//
// 性能比较：归并排序 > 三路快速排序 > 插入排序 > 冒泡排序
// 1w条随机数据排序结果:
// merge 耗时：0.014793
// quick 耗时：0.090507
// insert耗时：8.047739
// buble 耗时：20.687423


#import <Foundation/Foundation.h>

/**
 obj1.userId < obj2.userId; 是降序排列
 obj1.userId > obj2.userId; 是升序排列
 
 @param obj1 第一个对象
 @param obj2 第二个对象
 @return YES/NO
 */
typedef BOOL(^VSSorterComparisonBlock)(id obj1, id obj2);

@interface VSSorter : NSObject

/**
 三路快速排序 复杂度：nlogn
 
 @param arr <#arr description#>
 @param compare <#compare description#>
 */
+ (void)quickSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare;

/**
 归并排序    复杂度：nlogn
 
 @param arr <#arr description#>
 @param compare <#compare description#>
 */
+ (void)mergeSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare;

/**
 插入排序    复杂度： 最快 n 最慢n2
 
 @param arr <#arr description#>
 @param compare <#compare description#>
 */
+ (void)insertionSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare;

/**
 冒泡排序   复杂度： n2

 @param arr <#arr description#>
 @param compare <#compare description#>
 */
+ (void)bubleSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare;

@end

@interface NSMutableArray (SortTool)

- (void)st_swapIndex:(NSUInteger) idx1 otherIndex:(NSUInteger) idx2;

@end
