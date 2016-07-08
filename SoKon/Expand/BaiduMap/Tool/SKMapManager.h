//
//  SKMapManager.h
//  SoKon
//  地图管理类.初始化地图主引擎
//  Created by nachuan on 16/7/7.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>

@class BMKReverseGeoCodeResult;
@interface SKMapManager :BMKMapManager


/**
 *  单例对象
 */
+ (instancetype)manager;

///**
// *  保存本次反地理编码
// */
//+ (void)saveGeoCodeResult;

/**
 *  获取反上次的反地理编码
 */
//+ (BMKReverseGeoCodeResult *)reverseGeoCodeResult;

/**
 *  初始化百度地图主引擎
 *
 *  @return 启动结果,成功与否
 */
- (BOOL)start:(NSString *)appKey withGeneralDelegate:(id<BMKGeneralDelegate>)delegate;

/**
 *  初始化百度地图主引擎
 *  @param yesOrNo  是否开启定位服务
 *
 *  @return 启动结果,成功与否
 */
- (BOOL)start:(NSString *)appKey withGeneralDelegate:(id<BMKGeneralDelegate>)delegate startLocationService:(BOOL)yesOrNo;

/**
 *  初始化百度地图主引擎
 *  @param yesOrNo  是否开启定位服务
 *  @param resultYesOrNo  是否存储本次反地理编码结果 当resultYesOrNo为yes时.yesOrNo不再起作用
 *
 *  @return 启动结果,成功与否
 */

//- (BOOL)startWithGeneralDelegate:(id<BMKGeneralDelegate>)delegate startLocationService:(BOOL)yesOrNo saveReverseGeoCodeResult:(BOOL)resultYesOrNo;

/**
 *  开启定位服务
 */
- (void)startLocationService;

/**
 *  开启定位服务并存储反地理编码结果
 */
//- (void)startLocationServiceAndSaveReverseGeoCodeResult;

@end
