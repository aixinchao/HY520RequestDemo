//
//  HYRequestManager.h
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/2/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYNetManager.h"
#import "HYBaseRequest.h"
#import "HYNetCacheManager.h"

/**
 *  数据解析器类型
 */
typedef NS_ENUM(NSUInteger, HYResponseSerializerType) {
    /**
     *  默认类型 JSON  如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    HYResponseSerializerTypeDefault,
    /**
     *  JSON类型 如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    HYResponseSerializerTypeJSON,
    /*
     *  XML类型 如果使用这个响应解析器类型,那么请求返回的数据将会是XML格式
     */
    HYResponseSerializerTypeXML,
    /**
     *  Plist类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Plist格式
     */
    HYResponseSerializerTypePlist,
    /*
     *  Compound类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Compound格式
     */
    HYResponseSerializerTypeCompound,
    /**
     *  Image类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Image格式
     */
    HYResponseSerializerTypeImage,
    /**
     *  Data类型 如果使用这个响应解析器类型,那么请求返回的数据将会是二进制格式
     */
    HYResponseSerializerTypeData
};
/**
 *  网络状态
 */
typedef NS_ENUM(NSUInteger,HYReachabilityStatus) {
    /**
     *  网络状态未知
     */
    HYReachabilityStatusUnknown,
    /**
     *  没有网络
     */
    HYReachabilityStatusNotReachable,
    /**
     *  3G|4G蜂窝移动网络
     */
    HYReachabilityStatusReachableViaWWAN,
    /**
     *  WIFI网络
     */
    HYReachabilityStatusReachableViaWiFi,
};

@interface HYRequestManager : NSObject

/**
 *  GET请求 By NSURLSession
 *
 *  @param URLString            URL
 *  @param parameters           参数
 *  @param type                 数据解析器类型
 *  @param downloadProgress     下载进度
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param hudSuperView         请求的数据的加载视图的父视图
 *  @param cache                是否需要缓存数据
 */
+ (NSURLSessionDataTask *_Nullable)GET:(NSString *_Nullable)URLString
                            parameters:(id _Nullable )parameters
                 responseSeializerType:(HYResponseSerializerType)type
                              progress:(void(^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgress
                               success:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                          hudSuperView:(UIView *_Nullable)hudSuperView
                                 cache:(BOOL)cache;

/**
 *  POST请求 By NSURLSession
 *
 *  @param URLString            URL
 *  @param parameters           参数
 *  @param type                 数据解析器类型
 *  @param uploadProgress       上传进度
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param hudSuperView         请求的数据的加载视图的父视图
 *  @param cache                是否需要缓存数据
 */
+ (NSURLSessionDataTask *_Nullable)POST:(NSString *_Nullable)URLString
                             parameters:(id _Nullable )parameters
                  responseSeializerType:(HYResponseSerializerType)type
                               progress:(void(^_Nullable)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                           hudSuperView:(UIView *_Nullable)hudSuperView
                                  cache:(BOOL)cache;

/**
 *  POST请求 上传数据 By NSURLSession
 *
 *  @param URLString            URL
 *  @param parameters           参数
 *  @param block                返回Body的formData数据block
 *  @param type                 数据解析器类型
 *  @param uploadProgress       上传进度
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param hudSuperView              请求的数据的加载视图的父视图
 */
+ (NSURLSessionDataTask *_Nullable)POST:(NSString *_Nullable)URLString
                             parameters:(id _Nullable )parameters
                  responseSeializerType:(HYResponseSerializerType)type
              constructingBodyWithBlock:(void (^_Nullable)(id<AFMultipartFormData> _Nullable formData))block
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(void(^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
                           hudSuperView:(UIView *_Nullable)hudSuperView;

/**
 *  下载数据
 *
 *  @param URLString            URL
 *  @param filePath             下载路径
 *  @param downloadProgress     下载进度
 *  @param completion           下载结果回调
 */
+ (NSURLSessionDownloadTask *_Nullable)downloadTask:(NSString *_Nullable)URLString
                                           filePath:(NSString *_Nullable)filePath
                                           progress:(void(^_Nullable)(NSProgress * _Nullable downloadProgress))downloadProgress
                                         completion:(void(^_Nullable)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completion;

/**
 *  取消所有的网络请求
 */
+ (void)cancelAllRequests;

/**
 * 监听网络状态
 * @param statuBlock 网络变化监听回调
 */
+ (void)monitoringReachabilityStatusChangeBlock:(void (^_Nullable)(HYReachabilityStatus))statuBlock;


@end
