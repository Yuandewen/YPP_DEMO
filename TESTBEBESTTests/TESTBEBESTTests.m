//
//  TESTBEBESTTests.m
//  TESTBEBESTTests
//
//  Created by wandaios on 2017/11/15.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+YP.h"

@interface TESTBEBESTTests : XCTestCase

@end

@implementation TESTBEBESTTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [self testCharacterAPI];
}
#pragma mark - 分类方法测试
- (void)test{
    NSArray *a = @[@"1",@"2",@"3",@"4"];
    NSArray *b = @[@"2",@"3",@"4",@"5",@"6",@"7"];
    NSLog(@"result --- %@",[b arrayMinusOtherArray:a]);
    
}
#pragma mark - NSCharacterSet学习
- (void)testCharacterAPI{
    // 去掉str中的字符串【今我向】
    NSString *str = @"今天我们要好好学习，天天向上，因为，我饿了";
    NSString *str1 = @"今我向";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:str1];
    NSArray *arr = [str componentsSeparatedByCharactersInSet:set] ;
    NSString *resultString = [arr componentsJoinedByString:@""];
    NSLog(@"resultString --- %@",resultString);
    
    NSString *muStr = @"我们  好好  谨记  动态9";
    NSMutableCharacterSet *muSet = [NSMutableCharacterSet whitespaceCharacterSet];
    [muSet addCharactersInString:@"9"];

    NSArray *muArr = [muStr componentsSeparatedByCharactersInSet:muSet];
    NSLog(@"muResultString --- %@",[muArr componentsJoinedByString:@""]);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
    }];
}

@end
