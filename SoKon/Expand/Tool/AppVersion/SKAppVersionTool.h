//
//  SKAppVersionTool.h
//  SoKon
//
//  Created by nachuan on 16/6/28.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKAppVersionTool : NSObject

/** 获取先前app版本号 */
+ (CGFloat)appVersion;

/** 存储当前app版本号 */
+ (void)setAppVersion;

/** 判断是否是新版本 */
+ (BOOL)isNewVersion;

@end
