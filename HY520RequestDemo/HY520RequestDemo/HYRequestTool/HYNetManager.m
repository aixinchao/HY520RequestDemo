//
//  HYNetManager.m
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/2/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import "HYNetManager.h"

@implementation HYNetManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self requestIdentifierDictionary];
    }
    return self;
}

+ (instancetype)shareManager
{
    static HYNetManager *_netManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _netManager = [[self alloc] init];
    });
    return _netManager;
}

#pragma mark -- 添加baseRequest到requestIdentifierDictionary字典
- (void)addRequestIdentifierWithRequest:(HYBaseRequest *)baseRequest
{
    if (baseRequest.sessionDataTask != nil) {
        NSString *key = @(baseRequest.sessionDataTask.taskIdentifier).stringValue;
        [self.requestIdentifierDictionary setObject:baseRequest forKey:key];
    }
}

#pragma mark -- 移除baseRequest从requestIdentifierDictionary字典
- (void)removeRequestIdentifierWithRequest:(HYBaseRequest *)baseRequest
{
    NSString *key = @(baseRequest.sessionDataTask.taskIdentifier).stringValue;
    [self.requestIdentifierDictionary removeObjectForKey:key];
}

#pragma mark -- requestIdentifierDictionary
- (NSMutableDictionary *)requestIdentifierDictionary
{
    if (!_requestIdentifierDictionary) {
        _requestIdentifierDictionary = [NSMutableDictionary dictionary];
    }
    return _requestIdentifierDictionary;
}

@end
