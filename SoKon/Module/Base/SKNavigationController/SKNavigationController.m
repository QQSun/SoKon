//
//  SKNavigationController.m
//  SoKon
//
//  Created by nachuan on 16/6/23.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKNavigationController.h"

@interface SKNavigationController ()

@end

@implementation SKNavigationController


/**
 *  全局初始化一次
 */
+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    navigationBar.barTintColor = [UIColor orangeColor];
    navigationBar.tintColor = [UIColor redColor];

//    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *arr = self.childViewControllers;
    if (arr.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
