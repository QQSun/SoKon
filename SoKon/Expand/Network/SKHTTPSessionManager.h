//
//  SKHTTPSessionManager.h
//  SoKon
//
//  Created by nachuan on 16/6/24.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>
#endif
#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_WATCH || TARGET_OS_TV
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import "AFURLSessionManager.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFURLResponseSerialization.h>
@interface SKHTTPSessionManager : AFURLSessionManager <NSSecureCoding, NSCopying>

typedef NSURLSessionDataTask SKURLSessionDataTask;
typedef NSURLSessionConfiguration SKURLSessionConfiguration;

typedef void (^SKFormData)(id <AFMultipartFormData> formData);
typedef void (^SKResponseSuccess)(SKURLSessionDataTask *task, id responseObject);
typedef void (^SKResponseFailure)(SKURLSessionDataTask *task, NSError *error);
typedef void (^SKUploadProgress)(NSProgress *uploadProgress);
typedef void (^SKDownloadProgress)(NSProgress *downloadProgress);

/**
 *  基址.用于拼接其他地址使用
 */
@property (nonatomic, strong, readwrite) NSURL *baseURL;

/**
 *  请求序列化.不可以为nil
 */
@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerializer;

/**
 *  返回结果序列化,不可以为nil
 */
@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer;

/**
 *  创建并返回SKHTTPSessionManager实例对象
 */
+ (instancetype)manager;

/**
 *  用特殊baseURL初始化一个SKHTTPSessionManager实例对象
 *
 *  @param baseURL 基址
 */
- (instancetype)initWithBaseURL:(NSURL *)baseURL;

/**
 *  最终指定构造器.所有的构造方法都将最终调用该方法
 *
 *  @param baseURL       基址
 *  @param configuration SKURLSessionConfiguration实例
 */
- (instancetype)initWithBaseURL:(NSURL *)baseURL sessionConfiguration:(SKURLSessionConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 *  get请求.不推荐使用
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @param return 当前的请求任务
 */
- (SKURLSessionDataTask *)sk_get:(NSString *)URLString
                       parameters:(id)parameters
                          success:(SKResponseSuccess)success
                          failure:(SKResponseFailure)failure DEPRECATED_ATTRIBUTE;

/**
 *  get请求,推荐使用
 *
 *  @param URLString        请求地址
 *  @param parameters       请求参数
 *  @param downloadProgress 下载过程回调
 *  @param success          成功回调
 *  @param failure          失败回调
 *
 *  @return 当前的请求任务
 */
- (SKURLSessionDataTask *)sk_get:(NSString *)URLString
                       parameters:(id)parameters
                         progress:(SKDownloadProgress)downloadProgress
                          success:(SKResponseSuccess)success
                          failure:(SKResponseFailure)failure;

/**
 *  head请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 当前的请求任务
 */
- (SKURLSessionDataTask *)sk_head:(NSString *)URLString
                    parameters:(id)parameters
                       success:(SKResponseSuccess)success
                       failure:(SKResponseFailure)failure;


/**
 *  post请求,不推荐使用
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 当前请求任务
 */
- (SKURLSessionDataTask *)sk_post:(NSString *)URLString
                       parameters:(id)parameters
                          success:(SKResponseSuccess)success
                          failure:(SKResponseFailure)failure DEPRECATED_ATTRIBUTE;

/**
 *  post请求,推荐使用
 *
 *  @param URLString      请求地址
 *  @param parameters     请求参数
 *  @param uploadProgress 上传过程回调
 *  @param success        成功回调
 *  @param failure        失败回调
 *
 *  @return 当前请求任务
 */
- (SKURLSessionDataTask *)sk_post:(NSString *)URLString
                       parameters:(id)parameters
                         progress:(SKUploadProgress)uploadProgress
                          success:(SKResponseSuccess)success
                          failure:(SKResponseFailure)failure;

/**
 *  post请求,不推荐使用
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param block      简单的请求参数,添加到请求体(body)的后面
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 当前请求任务
 */
- (SKURLSessionDataTask *)sk_post:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(SKFormData)block
                                success:(SKResponseSuccess)success
                                failure:(SKResponseFailure)failure DEPRECATED_ATTRIBUTE;

/**
 *  post请求,推荐使用
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param block      简单的请求参数,添加到请求体(body)的后面
 *  @param progress   上传过程回调
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 当前请求任务
 */

- (SKURLSessionDataTask *)sk_post:(NSString *)URLString
                       parameters:(id)parameters
        constructingBodyWithBlock:(SKFormData)block
                         progress:(SKUploadProgress)uploadProgress
                          success:(SKResponseSuccess)success
                          failure:(SKResponseFailure)failure;

/**
 *  put请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 当前请求任务
 */
- (SKURLSessionDataTask *)sk_put:(NSString *)URLString
                      parameters:(id)parameters
                       successss:(SKResponseSuccess)success
                         failure:(SKResponseFailure)failure;

/**
 *  patch请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 当前请求任务
 */
- (SKURLSessionDataTask *)sk_patch:(NSString *)URLString
                        parameters:(id)parameters
                         successss:(SKResponseSuccess)success
                           failure:(SKResponseFailure)failure;
/**
 *  delete请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return 当前请求任务
 */
- (SKURLSessionDataTask *)sk_delete:(NSString *)URLString
                        parameters:(id)parameters
                         successss:(SKResponseSuccess)success
                           failure:(SKResponseFailure)failure;


@end
