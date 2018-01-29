//
//  TanLoginViewModel.h
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/26.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface TanLoginViewModel : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;
@end
