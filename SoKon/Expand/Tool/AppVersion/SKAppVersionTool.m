//
//  SKAppVersionTool.m
//  SoKon
//
//  Created by nachuan on 16/6/28.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKAppVersionTool.h"
#define kVersionKey @"CFBundleShortVersionString"
#define kVersionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"appVersion.data"]
@implementation SKAppVersionTool

+ (CGFloat)appVersion
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kVersionPath] floatValue];
}

+ (void)setAppVersion
{
    [[NSUserDefaults standardUserDefaults] setObject:kAppVersion forKey:kVersionPath];
}

+ (BOOL)isNewVersion
{
    CGFloat newVersion = [kAppVersion floatValue];
    CGFloat oldVersion = [self appVersion];
    [self setAppVersion];
    return oldVersion < newVersion;
}

@end
