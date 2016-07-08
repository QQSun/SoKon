//
//  SKThirdManager.h
//  SoKon
//
//  Created by nachuan on 16/7/7.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialSnsPlatformManager.h"
@interface SKThirdManager : NSObject
/**
 *  单例对象
 */
+ (instancetype)manager;

/**
 *  关闭友盟推送
 */
+ (void)unregisterForRemoteNotifications;

/**
 *  收到远程推送通知
 *
 *  @param userInfo 通知信息
 */
+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

/**
 *  注册百度地图,该方法在application: didFinishLaunchingWithOptions:中调用一次.
 *  请不要重复调用
 */
- (void)registerBaiduMapWithDelegate:(id)delegate;

/**
 *  注册友盟社会化分享,该方法在application: didFinishLaunchingWithOptions:中调用一次.
 *  请不要重复调用
 */
- (void)registerUMengSocial;

/**
 *  注册友盟消息模块.推送
 */
- (void)registerUMessageWithLaunchOptions:(NSDictionary *)options;

/**
 *  注册友盟统计(无IDFA版本)
 */
- (void)registerUMengAnalyticsNoIDFA;

/**
 *  系统回调配置
 *
 *  @param app     回调对象
 *  @param url     回调地址
 *  @param options 选择项
 *
 *  @return 回调成功与否
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;

/**
 *  设置第三方登录平台信息
 *
 *  @param type                 登录平台类型 详情见UMSocialSnsPlatformManager.h
 *  @param presentingController 点击后弹出的分享页面或者授权页面所在的UIViewController对象
 */
- (void)setThirdPlatformForLoginWithType:(NSString *)type presentingController:(UIViewController *)presentingController;


/**
 *  设置QQ登录平台
 *  @param presentingController 点击后弹出的分享页面或者授权页面所在的UIViewController对象
 */
- (void)setQQPlatformForLoginWithPresentingController:(UIViewController *)presentingController;

/**
 *  设置微信登录平台
 *  @param presentingController 点击后弹出的分享页面或者授权页面所在的UIViewController对象
 */
- (void)setWXPlatformForLoginWithPresentingController:(UIViewController *)presentingController;

/**
 *  设置新浪登录平台
 *  @param presentingController 点击后弹出的分享页面或者授权页面所在的UIViewController对象
 */
- (void)setSinaPlatformForLoginWithPresentingController:(UIViewController *)presentingController;

/**
 *  删除授权信息
 *
 *  @param type 授权分类
 */
- (void)requestUnOauthWithType:(NSString *)type;



@end
