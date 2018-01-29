//
//  TanLoginViewModel.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/26.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "TanLoginViewModel.h"
#import "TanNetworker.h"

@implementation TanLoginViewModel
- (instancetype)init{
    if(self = [super init]){
        
        RACSignal *userNameLengthSig = [RACObserve(self, userName) map:^id _Nullable(NSString *value) {
            NSLog(@"userNameLengthSig -- %@",value);
            return value.length>6 ? @(YES) : @(NO);
        }];
        RACSignal *passwordLengthSig = [RACObserve(self, password) map:^id _Nullable(NSString *value) {
            NSLog(@"passwordLengthSig -- %@",value);
            return value.length>6 ? @(YES) : @(NO);
        }];
        RACSignal *loginBtnEnable = [RACSignal combineLatest:@[userNameLengthSig,passwordLengthSig] reduce:^id(NSNumber *userName,NSNumber *password){
            NSLog(@"loginBtnEnable -- %@ -- %@",userName,password);
            return @([userName boolValue] && [password boolValue]);
        }];
        
        _loginCommand = [[RACCommand alloc] initWithEnabled:loginBtnEnable signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSLog(@"_loginCommand -- %@",input);
            return [TanNetworker loginWithUserName:self.userName password:self.password];
        }];
    }
    return self;
}

@end
