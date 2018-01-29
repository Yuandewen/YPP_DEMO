//
//  MethodExtension.h
//  TESTBEBEST
//
//  Created by wandaios on 2017/11/15.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodExtension : NSObject

- (instancetype _Nullable )initWithTitle:(NSString * _Nonnull)title;

@property (nonatomic, assign ,readonly,nonnull) NSString *title;

@property (nonatomic, copy) NSString * _Nonnull className;

@end
