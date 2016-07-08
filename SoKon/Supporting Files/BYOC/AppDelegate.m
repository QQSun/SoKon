//
//  AppDelegate.m
//  SoKon
//
//  Created by nachuan on 16/6/23.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "AppDelegate.h"
#import "SKWindowTool.h"
#import "SKThirdManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [SKWindowTool setWindowRootViewController:self.window];//初始化window的rootViewController
    
    SKThirdManager *manager = [SKThirdManager manager];
    [manager registerBaiduMapWithDelegate:nil];//注册百度地图
    [manager registerUMengSocial];//注册友盟社交
    [manager registerUMengAnalyticsNoIDFA];//注册友盟统计
    [manager registerUMessageWithLaunchOptions:launchOptions];//注册友盟消息(推送)
    
    
    return YES;
}

/**
 *  接收到远程通知回调
 *  @param userInfo    通知信息
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [SKThirdManager didReceiveRemoteNotification:userInfo];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    SKThirdManager *manager = [SKThirdManager manager];
    return [manager application:app openURL:url options:options];   //处理回调
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
