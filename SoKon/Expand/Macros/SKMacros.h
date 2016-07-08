//
//  SKMacros.h
//  SoKon
//
//  这是一个全局宏定义
//  Created by nachuan on 16/6/27.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#ifndef SKMacros_h
#define SKMacros_h

/** 自定义打印函数 */
#if DEBUG
#define SKLog(xx,...) NSLog(@"%s--%d行--%@",__FUNCTION__,__LINE__, [NSString stringWithFormat:xx, ##__VA_ARGS__])
#else
#define SKLog(xx,...) nil
#endif

/** app版本号 */
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



/** color */
#define kBGColor UIColorHex(#dddddd)

#endif /* SKMacros_h */
