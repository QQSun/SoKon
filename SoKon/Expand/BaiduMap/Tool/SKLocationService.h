//
//  SKLocationService.h
//  SoKon
//  程序刚起动时定位相关类
//  Created by nachuan on 16/7/5.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKUserLocation.h>
@class BMKLocationService;
@interface SKLocationService : NSObject

///** 用户位置信息，尚未定位成功，则该值为nil */
@property (nonatomic, strong, readonly) BMKUserLocation *userLocation;

/**
 *  单例对象
 */
+ (instancetype)instance;

+ (NSString *)reverseGeoCodeResult;

/**
 *  开启定位服务
 */
- (void)starLocationService;

@end
