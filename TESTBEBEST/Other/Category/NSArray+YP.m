//
//  NSArray+YP.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/11/15.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "NSArray+YP.h"

@implementation NSArray (YP)
- (NSArray *)arrayMinusOtherArray:(NSArray *)otherArray{
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSInteger arrayCount = self.count;
    for(int i=0;i<arrayCount;i++){
        id obj = self[i];
        if(![otherArray containsObject:obj]){
            [resultArray addObject:obj];
        }
    }
    NSInteger otherArrayCount = otherArray.count;
    for(int i=0;i<otherArrayCount;i++){
        id obj = otherArray[i];
        if(![self containsObject:obj] && ![resultArray containsObject:obj]){
            [resultArray addObject:obj];
        }
    }
    
    [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
    
    return resultArray.count==0 ? nil :resultArray;
    
}
@end
