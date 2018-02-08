//
//  PageViewController.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/2/6.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *myPageViewController;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger controllerIndex;
@end

@implementation PageViewController
- (NSArray *)dataArray{
    if(!_dataArray){
        UIViewController *controller01 = [UIViewController new];
        controller01.view.backgroundColor = [UIColor redColor];
        UIViewController *controller02 = [UIViewController new];
        controller02.view.backgroundColor = [UIColor yellowColor];
        UIViewController *controller03 = [UIViewController new];
        controller03.view.backgroundColor = [UIColor blueColor];
        _dataArray = @[controller01,controller02,controller03];
    }
    return _dataArray;
}
- (UIPageViewController *)myPageViewController{
    if(!_myPageViewController){
        _myPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _myPageViewController.delegate = self;
        _myPageViewController.dataSource = self;
    }
    return _myPageViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.controllerIndex = 1;
    
    
    [self addChildViewController:self.myPageViewController];
    [self.view addSubview:self.myPageViewController.view];
    
    UIViewController *currentController = self.dataArray[self.controllerIndex];
    [self.myPageViewController setViewControllers:@[currentController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
        NSLog(@"finish --- %d",finished);
    }];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    UIViewController *controller01 = [UIViewController new];
    controller01.view.backgroundColor = [UIColor redColor];
    if(viewController == controller01){
        return nil;
    }
    return controller01;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    UIViewController *controller03 = [UIViewController new];
    controller03.view.backgroundColor = [UIColor blueColor];
    if(viewController == controller03){
        return nil;
    }
    return controller03;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    NSLog(@"pendingViewControllers --- %@",pendingViewControllers);
}

@end
