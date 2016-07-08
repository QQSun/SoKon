//
//  SKAccountTool.h
//  SoKon
//
//  Created by nachuan on 16/6/28.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKAccount.h"
@interface SKAccountTool : NSObject

/** 获取账号信息 */
+ (SKAccount *)account;

/** 存储账号信息 */
+ (void)setAccount:(SKAccount *)account;


@end
