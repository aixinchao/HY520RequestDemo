//
//  HYNetCacheManager.h
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/3/6.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "HYBaseRequest.h"

@interface HYNetCacheManager : NSObject

/**
 *  处理缓存的单例类
 */
+ (HYNetCacheManager *)shareManager;

/**
 *  根据key把object写入缓存
 */
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

/**
 *  根据key读取数据
 */
- (id<NSCoding>)objectForKey:(NSString *)key;

/**
 *  根据key移除缓存
 */
- (void)removeObjectForKey:(NSString *)key;

/**
 *  移除所有缓存
 */
- (void)clearCache;

/**
 *  根据URL和请求类型和参数 获取缓存的key
 *
 *  @param request            request
 */
+ (NSString *)cacheKeyWithRequest:(HYBaseRequest *)request;

@end
