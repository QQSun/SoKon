//
//  SKHTTPSessionManager.m
//  SoKon
//
//  Created by nachuan on 16/6/24.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKHTTPSessionManager.h"

@implementation SKHTTPSessionManager
@dynamic responseSerializer;

+ (instancetype)manager
{
//    return [[self alloc] initWithBaseURL:nil];
    
    static SKHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:nil];
    });
    return manager;
}

- (instancetype)init
{
    return [self initWithBaseURL:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL
{
    return [self initWithBaseURL:baseURL sessionConfiguration:nil];
}

- (instancetype)initWithSessionConfiguration:(SKURLSessionConfiguration *)configuration
{
    return [self initWithBaseURL:nil sessionConfiguration:configuration];
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL sessionConfiguration:(SKURLSessionConfiguration *)configuration
{
    self = [super initWithSessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    //确保baseURL路径以@"/"结尾,来保证NSURL +URLWithString:relativeToURL:正常执行
    if ([[baseURL path] length] > 0 && ![baseURL.absoluteString hasSuffix:@"/"]) {
        baseURL = [baseURL URLByAppendingPathComponent:@""];
    }
    self.baseURL = baseURL;
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    return self;
}

#pragma mark - serializer setter方法

- (void)setRequestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
{
    NSParameterAssert(requestSerializer);
    _requestSerializer = requestSerializer;
}

- (void)setResponseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
{
    NSParameterAssert(responseSerializer);
    [super setResponseSerializer:responseSerializer];
}


#pragma mark - get相关请求方法
- (SKURLSessionDataTask *)sk_get:(NSString *)URLString parameters:(id)parameters success:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    return [self sk_get:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (SKURLSessionDataTask *)sk_get:(NSString *)URLString parameters:(id)parameters progress:(SKUploadProgress)downloadProgress success:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    SKURLSessionDataTask *dataTask = [self sk_dataTaskWithHttpMethod:@"GET" URLStirng:URLString parameters:parameters uploadProgress:nil downloadProgress:downloadProgress success:success failure:failure];
    [dataTask resume];
    return dataTask;
}

#pragma mark - head相关请求方法

- (SKURLSessionDataTask *)sk_head:(NSString *)URLString parameters:(id)parameters success:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    SKURLSessionDataTask *dataTask = [self sk_dataTaskWithHttpMethod:@"HEAD" URLStirng:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}

#pragma mark - post相关请求方法

- (SKURLSessionDataTask *)sk_post:(NSString *)URLString parameters:(id)parameters success:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    return [self sk_post:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (SKURLSessionDataTask *)sk_post:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))uploadProgress success:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    SKURLSessionDataTask *dataTask = [self sk_dataTaskWithHttpMethod:@"POST" URLStirng:URLString parameters:parameters uploadProgress:uploadProgress downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}

- (SKURLSessionDataTask *)sk_dataTaskWithHttpMethod:(NSString *)method
                                          URLStirng:(NSString *)URLString
                                         parameters:(id)parameters
                                     uploadProgress:(SKUploadProgress)uploadProgress
                                   downloadProgress:(SKDownloadProgress)downloadProgress
                                            success:(SKResponseSuccess)success
                                            failure:(SKResponseFailure)failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
//这组宏的作用是用来消除特定区域的clang的编译警告，-Wgnu则是消除？：警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ? : dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        return nil;
    }
    __block SKURLSessionDataTask *dataTask = nil;
    request = [self modifyRequest:request withParameters:parameters];
    dataTask = [self dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        }else{
            if (success) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    success(dataTask, dic);
                }else{
                    success(dataTask, responseObject);
                }
            }
        }
    }];
    return dataTask;
}


- (SKURLSessionDataTask *)sk_post:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(SKFormData)block success:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    return [self sk_post:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:success failure:failure];
}

- (SKURLSessionDataTask *)sk_post:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(SKFormData)block progress:(SKUploadProgress)uploadProgress success:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
//这个的作用是用来消除特定区域的clang的编译警告，-Wgnu则是消除？：警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ? : dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
    }
    
    __block SKURLSessionDataTask *dataTask = nil;
    request = [self modifyRequest:request withParameters:parameters];
    dataTask = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        }else{
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    [dataTask resume];
    return dataTask;
}

/**
 *  设置请求参数的相关信息
 *
 *  @param request    请求实体
 *  @param parameters 请求参数
 *
 *  @return 修改后的请求实体
 */
- (NSMutableURLRequest *)modifyRequest:(NSMutableURLRequest *)request withParameters:(id)parameters
{
    if ([request.HTTPMethod isEqualToString:@"GET"]) {
        return request;
    }
    NSString *str=nil;
    if (parameters == nil) {
        str = @"";
    }else{
        str = [NSString stringWithFormat:@"%@", [parameters jsonStringEncoded]];
    }
    NSString *msgLength = [NSString stringWithFormat:@"%ld", (unsigned long)[str length]];
    [request setValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: [str dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"x-requested-with"];
    
    return request;
}

#pragma mark - put相关请求方法

- (SKURLSessionDataTask *)sk_put:(NSString *)URLString parameters:(id)parameters successss:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    SKURLSessionDataTask *dataTask = [self sk_dataTaskWithHttpMethod:@"PUT" URLStirng:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}

#pragma mark - patch相关请求方法

- (SKURLSessionDataTask *)sk_patch:(NSString *)URLString parameters:(id)parameters successss:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    SKURLSessionDataTask *dataTask = [self sk_dataTaskWithHttpMethod:@"PATCH" URLStirng:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}

#pragma mark - delete相关请求方法

- (SKURLSessionDataTask *)sk_delete:(NSString *)URLString parameters:(id)parameters successss:(SKResponseSuccess)success failure:(SKResponseFailure)failure
{
    SKURLSessionDataTask *dataTask = [self sk_dataTaskWithHttpMethod:@"DELETE" URLStirng:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}


#pragma mark - description

/**
 *  重写打印信息
 */
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, baseURL: %@, session: %@, operationQueue: %@>",NSStringFromClass([self class]), self, self.baseURL.absoluteString, self.session, self.operationQueue];
}


#pragma mark - NSSecureCoding协议
/**
 *  遵守的NSSecureCoding协议
 */
+ (BOOL)supportsSecureCoding
{
    return YES;
}

#pragma mark - NSCoding协议

/**
 *  解码
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    NSURL *baseURL = [decoder decodeObjectOfClass:[NSURL class] forKey:NSStringFromSelector(@selector(baseURL))];
    NSURLSessionConfiguration *configuration = [decoder decodeObjectOfClass:[NSURLSessionConfiguration class] forKey:@"sessionConfiguration"];
    if (!configuration) {
        NSString *configurationIdentifier = [decoder decodeObjectOfClass:[NSString class] forKey:@"identifier"];
        if (configurationIdentifier) {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 1100)
            configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:configurationIdentifier];
#else
            configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:configurationIdentifier];
#endif
        }
    }
    
    self = [self initWithBaseURL:baseURL sessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    self.requestSerializer = [decoder decodeObjectOfClass:[AFHTTPRequestSerializer class] forKey:NSStringFromSelector(@selector(requestSerializer))];
    self.responseSerializer = [decoder decodeObjectOfClass:[AFHTTPResponseSerializer class] forKey:NSStringFromSelector(@selector(responseSerializer))];
    AFSecurityPolicy *decodedPolicy = [decoder decodeObjectOfClass:[AFSecurityPolicy class] forKey:NSStringFromSelector(@selector(securityPolicy))];
    if (decodedPolicy) {
        self.securityPolicy = decodedPolicy;
    }
    return self;
}


/**
 *  编码
 */
- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeObject:self.baseURL forKey:NSStringFromSelector(@selector(baseURL))];
    if ([self.session.configuration conformsToProtocol:@protocol(NSCoding)]) {
        [coder encodeObject:self.session.configuration forKey:@"sessionConfiguration"];
    }else{
        [coder encodeObject:self.session.configuration.identifier forKey:@"identifier"];
    }
    [coder encodeObject:self.requestSerializer forKey:NSStringFromSelector(@selector(requestSerializer))];
    [coder encodeObject:self.responseSerializer forKey:NSStringFromSelector(@selector(responseSerializer))];
    [coder encodeObject:self.securityPolicy forKey:NSStringFromSelector(@selector(securityPolicy))];
}

#pragma mark - NSCopying 协议

- (instancetype)copyWithZone:(NSZone *)zone
{
    SKHTTPSessionManager *httpClient = [[[self class] allocWithZone:zone] initWithBaseURL:self.baseURL sessionConfiguration:self.session.configuration];
    httpClient.requestSerializer = self.requestSerializer;
    httpClient.responseSerializer = self.responseSerializer;
    httpClient.securityPolicy = self.securityPolicy;
    return httpClient;
}

@end
