//
//  NSDate+YP.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/12/1.
//  Copyright © 2017年 dcz. All rights reserved.
//

#import "NSDate+YP.h"

@implementation NSDate (YP)
- (NSDateComponents *)compareOtherDate:(NSDate *)otherDate{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar]; // 当前日历
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond; // 需要对比的时间参数
    NSDateComponents *components = [currentCalendar components:unit fromDate:self toDate:otherDate options:0];
    return components;
}

@end
