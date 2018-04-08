//
//  HYNetCacheManager.m
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/3/6.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import "HYNetCacheManager.h"

@interface HYNetCacheManager()

@property (nonatomic,strong) YYCache *cache;

@end

@implementation HYNetCacheManager

+ (HYNetCacheManager *)shareManager
{
    static HYNetCacheManager *_netCacheManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _netCacheManager = [[HYNetCacheManager alloc] init];
    });
    return _netCacheManager;
}

#pragma mark -- 根据key把object写入缓存
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key
{
    [self.cache setObject:object forKey:key];
}

#pragma mark -- 根据key读取数据
- (id<NSCoding>)objectForKey:(NSString *)key
{
    return [self.cache objectForKey:key];
}

#pragma mark -- 根据key移除缓存
- (void)removeObjectForKey:(NSString *)key
{
    [self.cache removeObjectForKey:key];
}

#pragma mark -- 移除所有缓存
- (void)clearCache
{
    [self.cache removeAllObjects];
}

#pragma mark -- Property method
- (YYCache *)cache
{
    if (!_cache) {
        _cache = [YYCache cacheWithName:NSStringFromClass([self class])];
    }
    return _cache;
}

+ (NSString *)methodStringWithRequestMethodType:(HYRequestMethodType)requestMethodType
{
    switch (requestMethodType) {
        case HYRequestMethodTypeGet:
            return @"GET";
            break;
        case HYRequestMethodTypePost:
            return @"POST";
            break;
        case HYRequestMethodTypePut:
            return @"PUT";
            break;
        case HYRequestMethodTypeDelete:
            return @"DELETE";
            break;
        case HYRequestMethodTypeHead:
            return @"HEAD";
            break;
        case HYRequestMethodTypePatch:
            return @"PATCH";
            break;
        default:
            break;
    }
}

+ (NSString *)parameterStringWithParameters:(id)parameters {
    if ([parameters isKindOfClass:[NSDictionary class]] || [parameters isKindOfClass:[NSArray class]]) {
        NSError *error = nil;
        NSData *parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            return [[NSString alloc] initWithData:parametersData encoding:NSUTF8StringEncoding];
        } else {
            return nil;
        }
    } else if ([parameters isKindOfClass:[NSString class]]) {
        return parameters;
    } else {
        return nil;
    }
}

#pragma mark -- 根据URL和请求类型和参数 获取缓存的key
+ (NSString *)cacheKeyWithRequest:(HYBaseRequest *)request
{
    NSString *methodString = [NSString stringWithFormat:@"%@&%@",request.requestURLString,[self methodStringWithRequestMethodType:request.requestMethodType]];
    NSString *parametersString = [NSString stringWithFormat:@"%@&%@",methodString,[self parameterStringWithParameters:request.requestParameters]];
    return parametersString;
}

@end
