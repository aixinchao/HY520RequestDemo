//
//  HYRequestManager.m
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/2/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import "HYRequestManager.h"

@implementation HYRequestManager

#pragma mark -- GET请求
+ (NSURLSessionDataTask *_Nullable)GET:(NSString *)URLString
                            parameters:(id)parameters
                 responseSeializerType:(HYResponseSerializerType)type
                              progress:(void (^)(NSProgress * _Nullable))downloadProgress
                               success:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success
                               failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
                          hudSuperView:(UIView *_Nullable)hudSuperView
                                 cache:(BOOL)cache
{
    HYNetManager *manager = [HYNetManager shareManager];
    //设置超时时间
    [self setManagerRequestSerializerTimeoutInterval:manager time:10];
    //设置baseRequest
    HYBaseRequest *baseRequest = [self setBaseRequest:URLString parameters:parameters requestMethodType:HYRequestMethodTypeGet hudSuperView:hudSuperView cache:cache];
    baseRequest.sessionDataTask = [manager GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求URL:%@\n请求参数:%@\n返回数据:%@",URLString,parameters,responseObject);
        success(task,responseObject);
        [self handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求URL:%@\n请求参数:%@\n错误信息:%@",URLString,parameters,error);
        failure(task,error);
        [self handleRequestFailureWithSessionDatatask:task error:error];
    }];
    [manager addRequestIdentifierWithRequest:baseRequest];
    return baseRequest.sessionDataTask;
}

#pragma mark -- POST请求
+ (NSURLSessionDataTask *_Nullable)POST:(NSString *)URLString
                             parameters:(id)parameters
                  responseSeializerType:(HYResponseSerializerType)type
                               progress:(void (^)(NSProgress * _Nullable))uploadProgress
                                success:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success
                                failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
                           hudSuperView:(UIView *_Nullable)hudSuperView
                                  cache:(BOOL)cache
{
    HYNetManager *manager = [HYNetManager shareManager];
    //设置超时时间
    [self setManagerRequestSerializerTimeoutInterval:manager time:10];
    //设置baseRequest
    HYBaseRequest *baseRequest = [self setBaseRequest:URLString parameters:parameters requestMethodType:HYRequestMethodTypeGet hudSuperView:hudSuperView cache:cache];
    baseRequest.sessionDataTask = [manager POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求URL:%@\n请求参数:%@\n返回数据:%@",URLString,parameters,responseObject);
        success(task,responseObject);
        [self handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求URL:%@\n请求参数:%@\n错误信息:%@",URLString,parameters,error);
        failure(task,error);
        [self handleRequestFailureWithSessionDatatask:task error:error];
    }];
    [manager addRequestIdentifierWithRequest:baseRequest];
    return baseRequest.sessionDataTask;
}

#pragma mark -- 生成HYBaseRequest类
+ (HYBaseRequest *)setBaseRequest:(NSString *)URLString
                       parameters:(id)parameters
                requestMethodType:(HYRequestMethodType)requestMethodType
                     hudSuperView:(UIView *)hudSuperView
                            cache:(BOOL)cache
{
    HYBaseRequest *baseRequest = [[HYBaseRequest alloc] init];
    baseRequest.requestURLString = URLString;
    baseRequest.requestParameters = parameters;
    baseRequest.requestMethodType = requestMethodType;
    baseRequest.hudSuperView = hudSuperView;
    baseRequest.cache = cache;
    if (hudSuperView) {
        //这里设置hudView [hudSuperView addSubview:hudView]
    }
    return baseRequest;
}

#pragma mark -- 请求成功之后的操作 移除NSURLSessionDataTask对象 是否缓存数据
+ (void)handleRequestSuccessWithSessionDataTask:(NSURLSessionDataTask *)sessionDataTask
                                 responseObject:(id)responseObject
{
    HYBaseRequest *baseRequest = [HYNetManager shareManager].requestIdentifierDictionary[@(sessionDataTask.taskIdentifier).stringValue];
    if (baseRequest.hudSuperView) {
        //移除hudView 从hudSuperView
    }
    if (baseRequest.cache) {
        NSString *cacheKey = [HYNetCacheManager cacheKeyWithRequest:baseRequest];
        [[HYNetCacheManager shareManager] setObject:responseObject forKey:cacheKey];
    }
    [[HYNetManager shareManager] removeRequestIdentifierWithRequest:baseRequest];
}

#pragma mark -- 请求失败之后的操作 移除NSURLSessionDataTask对象 是否获取缓存数据
+ (void)handleRequestFailureWithSessionDatatask:(NSURLSessionDataTask *)sessionDataTask
                                          error:(NSError *)error
{
    HYBaseRequest *baseRequest = [HYNetManager shareManager].requestIdentifierDictionary[@(sessionDataTask.taskIdentifier).stringValue];
    if (baseRequest.hudSuperView) {
        //移除hudView 从hudSuperView
    }
    [[HYNetManager shareManager] removeRequestIdentifierWithRequest:baseRequest];
}

#pragma mark -- POST请求 上传数据
+ (NSURLSessionDataTask *_Nullable)POST:(NSString *_Nullable)URLString
                             parameters:(id _Nullable )parameters
                  responseSeializerType:(HYResponseSerializerType)type
              constructingBodyWithBlock:(void (^_Nullable)(id<AFMultipartFormData> _Nullable formData))block
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                           hudSuperView:(UIView *_Nullable)hudSuperView
{
    HYNetManager *manager = [HYNetManager shareManager];
    //设置超时时间
    [self setManagerRequestSerializerTimeoutInterval:manager time:30];
    NSURLSessionDataTask *task = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求URL:%@\n请求参数:%@\n返回数据:%@",URLString,parameters,responseObject);
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求URL:%@\n请求参数:%@\n错误信息:%@",URLString,parameters,error);
        failure(task,error);
    }];
    return task;
}

#pragma mark --  下载数据
+ (NSURLSessionDownloadTask *_Nullable)downloadTask:(NSString *_Nullable)URLString
                                           filePath:(NSString *_Nullable)filePath
                                           progress:(void(^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgress
                                         completion:(void(^_Nullable)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completion
{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *downloadUrl = [NSURL URLWithString:URLString];
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:downloadUrl];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:downloadRequest progress:downloadProgress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"下载URL:%@\n下载到此路径:%@",URLString,filePath);
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载URL:%@\n下载到此路径:%@\n错误信息:%@",URLString,filePath,error);
        completion(response,filePath,error);
    }];
    [downloadTask resume];
    return downloadTask;
}

#pragma mark -- 设置超时时间
+ (void)setManagerRequestSerializerTimeoutInterval:(HYNetManager *)manager time:(CGFloat)time
{
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = time;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}

#pragma mark -- 设置解析器类型
+ (AFHTTPResponseSerializer *)responseSearalizerWithSerilizerType:(HYResponseSerializerType)serializerType
{
    switch (serializerType) {
        case HYResponseSerializerTypeDefault:    // default is JSON
            return [AFJSONResponseSerializer serializer];
            break;
        case HYResponseSerializerTypeJSON:       // JSON
            return [AFJSONResponseSerializer serializer];
            break;
        case HYResponseSerializerTypeXML:        // XML
            return [AFXMLParserResponseSerializer serializer];
            break;
        case HYResponseSerializerTypePlist:      // Plist
            return [AFPropertyListResponseSerializer serializer];
            break;
        case HYResponseSerializerTypeCompound:   // Compound
            return [AFCompoundResponseSerializer serializer];
            break;
        case HYResponseSerializerTypeImage:      // Image
            return [AFImageResponseSerializer serializer];
            break;
        case HYResponseSerializerTypeData:       // Data
            return [AFHTTPResponseSerializer serializer];
            break;
        default:                                // 默认解析器为 JSON解析
            return [AFJSONResponseSerializer serializer];
            break;
    }
}

#pragma mark -- 取消所有的请求
+ (void)cancelAllRequests
{
    [[HYNetManager shareManager].operationQueue cancelAllOperations];
}

#pragma mark -- 监听网络状态
+ (void)monitoringReachabilityStatusChangeBlock:(void (^_Nullable)(HYReachabilityStatus))statuBlock
{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络状态未知");
                if (statuBlock) {
                    statuBlock(HYReachabilityStatusUnknown);
                }
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                if (statuBlock) {
                    statuBlock(HYReachabilityStatusNotReachable);
                }
                break;
            case  AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G蜂窝移动网络");
                if (statuBlock) {
                    statuBlock(HYReachabilityStatusReachableViaWWAN);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI网络");
                if (statuBlock) {
                    statuBlock(HYReachabilityStatusReachableViaWiFi);
                }
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end
