//
//  YPScaleTransition.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/2.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "YPScaleTransition.h"

@implementation YPScaleTransition
// required
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    // 开始的时候，containerView只有fromView，动画完成后被移除，toView不能自动添加，所以需要自己手动添加
    [containerView addSubview:toView];
    
    [transitionContext.containerView bringSubviewToFront:fromView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        fromView.alpha = 0.0f;
        fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        toView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformMakeScale(1.0f, 1.0);
        [transitionContext completeTransition:YES];
    }];
}
@end
