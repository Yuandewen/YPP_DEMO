//
//  YPScaleNavControllerAnimatedTransitioning.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/2.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "YPScaleNavControllerAnimatedTransitioning.h"
#import "YPScaleTransition.h"

@implementation YPScaleNavControllerAnimatedTransitioning
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    return [YPScaleTransition new];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"------step one------%@,%@",viewController,navigationController);
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"------step two------%@,%@",viewController,navigationController);
}
@end
