//
//  SKLocationService.m
//  SoKon
//  定位相关类
//  Created by nachuan on 16/7/5.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKLocationService.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#define kReverseGeoCodeResult @"reverseGeoCodeResult"

@interface SKLocationService () <BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

/** 位置服务对象 */
@property (nonatomic, strong) BMKLocationService *locationService;

/** 位置检索对象 */
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

/** 反geo检索信息对象 */
@property (nonatomic, strong) BMKReverseGeoCodeOption *geoCodeOption;

/** 是否存储反地理编码结果 */
@property (nonatomic, assign) BOOL saveReverseGeoCodeResult;
@end

@implementation SKLocationService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _geoCodeSearch   = [[BMKGeoCodeSearch alloc] init];
        _geoCodeOption   = [[BMKReverseGeoCodeOption alloc] init];
        _locationService = [[BMKLocationService alloc] init];
        _geoCodeSearch.delegate   = self;
        _locationService.delegate = self;

    }
    return self;
}

+ (instancetype)instance
{
    static SKLocationService *locationService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationService = [[self alloc] init];
    });
    return locationService;
}

+ (NSString *)reverseGeoCodeResult
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kReverseGeoCodeResult];
}

- (void)starLocationService
{
    [self.locationService startUserLocationService];
}
#pragma mark - 位置服务相关代理方法

/**
 *  用户方向发生更改后调用
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    _userLocation = userLocation;
    SKLog(@"%@",userLocation);
}

/**
 *  用户位置发生更改后调用
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _geoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
    [_geoCodeSearch reverseGeoCode:_geoCodeOption];
    [_locationService stopUserLocationService];
}

/**
 *  定位失败后调用
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    SKLog(@"%@",error);
}

/**
 *  根据地理坐标反编码回调方法
 *
 *  @param searcher 回调对象
 *  @param result   检索结果
 *  @param error    检索失败
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    SKLog(@"%@",[SKLocationService reverseGeoCodeResult]);
    
    [[NSUserDefaults standardUserDefaults] setObject:result.addressDetail.city forKey:kReverseGeoCodeResult];
    
    
}




- (void)dealloc
{
    _geoCodeOption   = nil;
    _geoCodeSearch   = nil;
    _locationService = nil;

}

@end
