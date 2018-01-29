//
//  Singleton.h
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/5.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Singleton_Instance_method_Interface(ClassName) + (ClassName *)instance;
#define Singleton_Instance_method_Impl(ClassName) \
+ (ClassName *)instance \
{   \
static ClassName *_g_##ClassName##_obj = nil;  \
static dispatch_once_t onceToken;   \
dispatch_once(&onceToken, ^{    \
_g_##ClassName##_obj = [[self singletonAlloc] init];    \
}); \
return _g_##ClassName##_obj;    \
}

@interface Singleton : NSObject
+ (id)singletonAlloc;
@end
