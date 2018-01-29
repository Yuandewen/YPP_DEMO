//
//  UserInfoModel.h
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/5.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "Singleton.h"

@interface UserInfoModel : Singleton
// 方法声明
Singleton_Instance_method_Interface(UserInfoModel) // 单例方法

/****************************************************************************************/
// 模型属性
@property (nonatomic, copy) NSString *name;

/****************************************************************************************/
@end
