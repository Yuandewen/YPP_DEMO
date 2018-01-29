//
//  TanNetworker.h
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/26.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
@interface TanNetworker : NSObject

+ (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)password;

@end
