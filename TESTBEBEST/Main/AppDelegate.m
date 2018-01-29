//
//  AppDelegate.m
//  TESTBEBEST
//
//  Created by wandaios on 2017/11/15.
//  Copyright © 2017年 dcz. All rights reserved.

//  围城的怪圈，不是一般人可以跳出来的，甚至没人可以跳出来

/*
 + (void)load;类虽未被使用，但会执行此方法
 
 - (NSData *)yp_UTF8String;UTF8String是系统自有的方法，不能重写，否则报错：
        Can't endBackgroundTask: no background task exists with identifier 3, or it may have already been ended. Break in UIApplicationEndBackgroundTaskError() to debug.
    导致app运行后马上退出
 - (const char *)UTF8String
 
 远程推送：
         消息结构 {
                  "aps": {
                         "alert":"This is some fancy message.",
                         "badge":6,
                         "sound": "default"
                         }
                 }
         当app处于后台或者杀掉进程，推送的消息app不做任何处理，获取推送的消息只能点击通知，如果想点击icon获取推送数据，需要后台接口配合
         app角标的显示由badge控制，badge为8，则显示8，
         badge为-1，角标保持原来数据不变，通知栏的消息不清零
         badge为0，角标不显示，通知栏消息清楚以前的消息
         在app内部设置 [UIApplication sharedApplication].applicationIconBadgeNumber =0;角标和通知栏都清零
         ⚠️注意：目前极光推送的Java架包，不添加badge，默认每发一条就自动➕1

 NSUserDefaults 在赋值时，object 和 key 不能一样，否则存储不上，用户安全相关的不建议使用，可以控制第一次登陆和版本等其他逻辑
 
*/

/**
   1,build settings -- Info.plist File 可修改info.plist文件路径
 
   2,APP ICON角标，如果不清除，删除app后重新下载，角标依然存在。例如：淘宝
 
 **/





#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 知识点


// 只在程序启动时，执行一次
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 有关远程通知的一些知识点
    [self remoteNotification:launchOptions];
    return YES;
}
#pragma mark - 有关远程通知的一些知识点
- (void)remoteNotification:(NSDictionary *)launchOptions{
    
    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    
    if(url){
        // 由其他用用程序通过 openURL:启动
    }
    NSString *bundleId = [launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
    if(bundleId){
        // 对应启动的源应用程序的bundle ID （NSString）
    }
#pragma mark - 方法已过期，请参照： UserNotifications
//    UILocalNotification *localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    if(localNotify){
//        // 点击本地推送进来
//    }
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo){
        // 点击远程进来
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
