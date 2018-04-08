//
//  HYNetManager.h
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/2/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HYBaseRequest.h"

@interface HYNetManager : AFHTTPSessionManager

@property (nonatomic,strong) NSMutableDictionary *requestIdentifierDictionary;

/**
 *  网络请求的单例类
 */
+ (instancetype)shareManager;

/**
 *  添加baseRequest到requestIdentifierDictionary字典
 *
 *  @param baseRequest          baseRequest
 */
- (void)addRequestIdentifierWithRequest:(HYBaseRequest *)baseRequest;

/**
 *  移除baseRequest从requestIdentifierDictionary字典
 *
 *  @param baseRequest          baseRequest
 */
- (void)removeRequestIdentifierWithRequest:(HYBaseRequest *)baseRequest;

@end
