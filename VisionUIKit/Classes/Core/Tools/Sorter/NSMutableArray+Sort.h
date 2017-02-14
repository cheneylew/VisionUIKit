//
//  NSMutableArray+Sort.h
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
#import "VSSorter.h"

@interface NSMutableArray (Sort)

- (void)vs_quickSortWithComparison:(VSSorterComparisonBlock) compare;
- (void)vs_mergeSortWithComparison:(VSSorterComparisonBlock) compare;
- (void)vs_insertionSortWithComparison:(VSSorterComparisonBlock) compare;
- (void)vs_bubleSortWithComparison:(VSSorterComparisonBlock) compare;

@end
