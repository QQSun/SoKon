//
//  SKWindowTool.m
//  SoKon
//
//  Created by nachuan on 16/6/28.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKWindowTool.h"
#import "SKAppVersionTool.h"
#import "SKGuideViewController.h"
#import "SKTabBarController.h"
#import "SKAccountTool.h"
#import "SKLoginViewController.h"
@implementation SKWindowTool

+ (void)setWindowRootViewController
{
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIWindow *window = [UIWindow appearanceWhenContainedInInstancesOfClasses:@[self]];
    if ([SKAppVersionTool isNewVersion]) {
        SKGuideViewController *guide = [[SKGuideViewController alloc] init];
        window.rootViewController = guide;
    }else{
        SKTabBarController *tabBar = [[SKTabBarController alloc] init];
        window.rootViewController = tabBar;
    }
}

+ (void)setWindowRootViewController:(UIWindow *)window
{
    window.backgroundColor    = kBGColor;

    SKAccount *account = [SKAccountTool account];
    if (!account) {
        SKTabBarController *tabBar     = [[SKTabBarController alloc] init];
        window.rootViewController = tabBar;
    }else{
//        SKGuideViewController *guide   = [[SKGuideViewController alloc] init];
//        self.window.rootViewController = guide;
        SKLoginViewController *login   = [[SKLoginViewController alloc] init];
        window.rootViewController = login;
    }
    [window makeKeyAndVisible];
}

@end
