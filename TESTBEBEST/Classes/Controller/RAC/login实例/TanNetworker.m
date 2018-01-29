//
//  TanNetworker.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/26.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "TanNetworker.h"

@implementation TanNetworker
+ (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)password{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 3), dispatch_get_main_queue(), ^{
            [subscriber sendNext:[NSString stringWithFormat:@"User %@ password %@, login!",name,password]];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}
@end
