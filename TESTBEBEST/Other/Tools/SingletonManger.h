//
//  SingletonManger.h
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/5.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "Singleton.h"
#import "UserInfoModel.h"

#define UUserDefaults    ([SingletonManger instance].user)    //保存信息

@interface SingletonManger : Singleton
// 方法声明
Singleton_Instance_method_Interface(SingletonManger)

// 用户信息
@property (nonatomic, readonly) UserInfoModel *user;
@end
