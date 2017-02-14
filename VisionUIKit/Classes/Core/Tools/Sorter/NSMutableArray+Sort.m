//
//  NSMutableArray+Sort.m
//  Test
//
//  Created by Dejun Liu on 2017/1/24.
//  Copyright © 2017年 xiaolu zhao. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

- (void)vs_quickSortWithComparison:(VSSorterComparisonBlock) compare {
    [VSSorter quickSort:(NSMutableArray *)self compare:compare];
}

- (void)vs_mergeSortWithComparison:(VSSorterComparisonBlock) compare {
    [VSSorter mergeSort:(NSMutableArray *)self compare:compare];
}

- (void)vs_insertionSortWithComparison:(VSSorterComparisonBlock) compare {
    [VSSorter insertionSort:(NSMutableArray *)self compare:compare];
}

- (void)vs_bubleSortWithComparison:(VSSorterComparisonBlock) compare {
    [VSSorter bubleSort:(NSMutableArray *)self compare:compare];
}

@end
