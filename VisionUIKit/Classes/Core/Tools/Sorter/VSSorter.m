//
//  SorterManager.m
//  Test
//
//  Created by Dejun Liu on 2017/1/23.
//  Copyright © 2017年 Dejun Liu. All rights reserved.
//

#import "VSSorter.h"

@implementation VSSorter

#pragma mark - 冒泡排序

+ (void)bubleSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare {
    NSUInteger n = arr.count;
    for (int i=0; i<n; i++) {
        for (int j=0; j<n-i-1; j++) {
            if (compare(arr[j], arr[j+1])) {
                [arr st_swapIndex:j otherIndex:j+1];
            }
        }
    }
}

#pragma mark - 快速排序

+ (void)quickSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare {
    srand(time(NULL));
    [VSSorter _quickSort:arr left:0 right:arr.count-1 compare:(VSSorterComparisonBlock) compare];
}

+ (void)_quickSort:(NSMutableArray *) arr left:(int) l right:(int) r compare:(VSSorterComparisonBlock) compare {
    if (l>=r) {
        return;
    }
    
    // partition
    [arr exchangeObjectAtIndex:l withObjectAtIndex:(rand()%(r-l+1)+l)];
    id v = arr[l];
    
    int lt = l;     //arr[l+1...lt] < v
    int gt = r+1;   //arr[gt...r] >v
    int i = l+1;    //arr[lt+1...i) == v
    while (i<gt) {
        if (!compare(arr[i],v)) {
            [arr exchangeObjectAtIndex:i withObjectAtIndex:lt+1];
            lt++;
            i++;
        }
        else if(compare(arr[i],v)) {
            [arr exchangeObjectAtIndex:i withObjectAtIndex:gt-1];
            gt--;
        }
        else {
            i++;
        }
    }
    
    [arr exchangeObjectAtIndex:l withObjectAtIndex:lt];
    [VSSorter _quickSort:arr left:l right:lt-1 compare:compare];
    [VSSorter _quickSort:arr left:gt right:r compare:compare];
}

#pragma mark - 插入排序

+ (void)insertionSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare {
    [VSSorter _insertionSort:arr leftIndex:0 rightIndex:arr.count-1 compare:compare];
}

+ (void)_insertionSort:(NSMutableArray *) arr leftIndex:(NSUInteger) l rightIndex:(NSUInteger) r compare:(VSSorterComparisonBlock) compare
{
    for (NSUInteger i=l+1; i<=r; i++) {
        //寻找arr[i]合适的插入位置
        id e = arr[i];
        NSUInteger j;  //j保存e应插入的位置
        for (j=i; j>l && compare(arr[j-1], e); j--) {
            arr[j] = arr[j-1];
        }
        arr[j] = e;
    }
}

#pragma mark - 归并排序

+ (void)mergeSort:(NSMutableArray *) arr compare:(VSSorterComparisonBlock) compare
{
    [VSSorter _mergeSort:arr leftIndex:0 rightIndex:arr.count-1 compare:compare];
}

+ (void)_mergeSort:(NSMutableArray *) arr
         leftIndex:(NSInteger) lIdx
        rightIndex:(NSInteger) rIdx
           compare:(VSSorterComparisonBlock) compare {
    if (rIdx - lIdx <= 15) {
        [VSSorter _insertionSort:arr leftIndex:lIdx rightIndex:rIdx compare:compare];
        return;
    }
    NSUInteger midIdx = (lIdx + rIdx) /2;  //lIdx+rIdx超过Int最大值，这里存在坑。
    [VSSorter _mergeSort:arr leftIndex:lIdx rightIndex:midIdx compare:compare];
    [VSSorter _mergeSort:arr leftIndex:midIdx+1 rightIndex:rIdx compare:compare];
    if (!compare(arr[midIdx], arr[midIdx+1])) { //优化：只针对无序的进行归并，已经有序的不需要再浪费时间进行归并了。
        [self _merge:arr leftIndex:lIdx middleIndex:midIdx rightIndex:rIdx compare:compare];
    }
}

+ (void)_merge:(NSMutableArray *) arr
     leftIndex:(NSInteger) lIdx
   middleIndex:(NSInteger) midIdx
    rightIndex:(NSInteger) rIdx
       compare:(VSSorterComparisonBlock) compare
{
    NSMutableArray *aux = [NSMutableArray arrayWithCapacity:rIdx-lIdx+1];
    for (NSUInteger i=lIdx; i<=rIdx; i++) {
        aux[i-lIdx] = arr[i];
    }
    
    NSInteger i=lIdx, j = midIdx+1;
    for (NSUInteger k=lIdx; k<=rIdx; k++) {
        if (i>midIdx) {
            arr[k] = aux[j-lIdx];
            j++;
        }
        else if(j > rIdx) {
            arr[k] = aux[i-lIdx];
            i++;
        }
        else if (compare(aux[i-lIdx], aux[j-lIdx])) {
            arr[k] = aux[i-lIdx];
            i++;
        }
        else {
            arr[k] = aux[j-lIdx];
            j++;
        }
    }
}

@end

@implementation NSMutableArray (SortTool)

- (void)st_swapIndex:(NSUInteger) one otherIndex:(NSUInteger) other {
    if (one != other) {
        NSMutableArray *arr = (NSMutableArray *)self;
        id obj = arr[one];
        arr[one] = arr[other];
        arr[other] = obj;
    }
}

@end
