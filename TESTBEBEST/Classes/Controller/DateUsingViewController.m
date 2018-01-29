//
//  DateUsingViewController.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/1.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "DateUsingViewController.h"
#import "NSDate+YP.h"
@interface DateUsingViewController ()

@end

@implementation DateUsingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *currentDate = [NSDate date];
    NSDate *twoDaysDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60*2];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// 格林尼治时间
    NSDateComponents *components = [currentDate compareOtherDate:twoDaysDate];
    NSLog(@"%ld",(long)components.day);
    self.view.backgroundColor = [UIColor redColor];

    
}

@end
