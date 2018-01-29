//
//  Singleton.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/5.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

/**
 覆盖这个方法是为了防止程序员使用
 */
+ (id)alloc{
    @throw [NSException exceptionWithName:@"单粒" reason:@"不要直接使用alloc，请使用singletonAlloc" userInfo:@{}];
    return nil;
}
+ (id)singletonAlloc{
   return [super alloc];
}
@end
