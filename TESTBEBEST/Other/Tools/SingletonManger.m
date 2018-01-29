//
//  SingletonManger.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/5.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "SingletonManger.h"


@implementation SingletonManger
// 方法实现
Singleton_Instance_method_Impl(SingletonManger)

- (UserInfoModel *)user{
    return [UserInfoModel instance];
}

@end
