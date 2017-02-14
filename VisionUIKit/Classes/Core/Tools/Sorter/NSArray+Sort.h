//
//  NSArray+Sort.h
//  Test
//
//  Created by Dejun Liu on 2017/1/24.
//  Copyright © 2017年 xiaolu zhao. All rights reserved.
//
// 性能比较：归并排序 > 三路快速排序 > 插入排序 > 冒泡排序
// 1w条随机数据排序结果:
// merge 耗时：0.014793
// quick 耗时：0.090507
// insert耗时：8.047739
// buble 耗时：20.687423

#import <Foundation/Foundation.h>
#import "NSMutableArray+Sort.h"

@interface NSArray (Sort)

- (NSArray *)vs_quickSortWithComparison:(VSSorterComparisonBlock) compare;
- (NSArray *)vs_mergeSortWithComparison:(VSSorterComparisonBlock) compare;
- (NSArray *)vs_insertionSortWithComparison:(VSSorterComparisonBlock) compare;
- (NSArray *)vs_bubleSortWithComparison:(VSSorterComparisonBlock) compare;

@end
