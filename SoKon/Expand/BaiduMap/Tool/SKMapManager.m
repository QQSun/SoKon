//
//  SKMapManager.m
//  SoKon
//
//  Created by nachuan on 16/7/7.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKMapManager.h"
#import "SKLocationService.h"
//#import <BaiduMapAPI_Search/BMKRouteSearchType.h>

//@interface SKMapManager ()
//
///**
// *  反地理编码结果
// */
//@property (nonatomic, strong, readonly) BMKReverseGeoCodeResult *reverseGeoCodeResult;
//
//@end

@implementation SKMapManager




+ (instancetype)manager
{
    static SKMapManager *mapManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (mapManager == nil) {
            mapManager = [[SKMapManager alloc] init];
        }
    });
    return mapManager;
}

+ (BMKReverseGeoCodeResult *)reverseGeoCodeResult
{
    return nil;
}


- (BOOL)start:(NSString *)appKey withGeneralDelegate:(id<BMKGeneralDelegate>)delegate
{
    BOOL ret = [self start:appKey generalDelegate:delegate];
    if (!ret) {
        SKLog(@"manager start failed!");
    }
    return ret;
}


- (void)startLocationService
{
    SKLocationService *locationService = [SKLocationService instance];
    [locationService starLocationService];
}

//- (void)startLocationServiceAndSaveReverseGeoCodeResult
//{
//    SKLocationService *locationService = [SKLocationService instance];
//    [locationService starLocationServiceAndReverseGeoCodeResult];
//}

- (BOOL)start:(NSString *)appKey withGeneralDelegate:(id<BMKGeneralDelegate>)delegate startLocationService:(BOOL)yesOrNo
{
    BOOL ret = [self start:appKey withGeneralDelegate:delegate];
    if (yesOrNo) {
        [self startLocationService];
    }
    return ret;
}

//- (BOOL)startWithGeneralDelegate:(id<BMKGeneralDelegate>)delegate startLocationService:(BOOL)yesOrNo saveReverseGeoCodeResult:(BOOL)ResultYesOrNo
//{
//    BOOL ret = [self startWithGeneralDelegate:delegate];
//    if (ResultYesOrNo) {
//        [self startLocationServiceAndSaveReverseGeoCodeResult];
//    }else{
//        if (yesOrNo) {
//            [self startLocationService];
//        }
//    }
//    return ret;
//}

@end
