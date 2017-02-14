//
//  NSArray+Sort.m
//  Test
//
//  Created by Dejun Liu on 2017/1/24.
//  Copyright © 2017年 xiaolu zhao. All rights reserved.
//

#import "NSArray+Sort.h"

@implementation NSArray (Sort)

- (NSArray *)vs_quickSortWithComparison:(VSSorterComparisonBlock) compare {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self];
    [mArr vs_quickSortWithComparison:compare];
    return mArr;
}

- (NSArray *)vs_mergeSortWithComparison:(VSSorterComparisonBlock) compare {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self];
    [mArr vs_mergeSortWithComparison:compare];
    return mArr;
}

- (NSArray *)vs_insertionSortWithComparison:(VSSorterComparisonBlock) compare {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self];
    [mArr vs_insertionSortWithComparison:compare];
    return mArr;
}

- (NSArray *)vs_bubleSortWithComparison:(VSSorterComparisonBlock) compare {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self];
    [mArr vs_bubleSortWithComparison:compare];
    return mArr;
}

@end
