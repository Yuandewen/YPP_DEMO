//
//  MethodExtension.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/11/15.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "MethodExtension.h"

@implementation MethodExtension
- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if(self){
        _title = title;
    }
    return self;
}
@end
