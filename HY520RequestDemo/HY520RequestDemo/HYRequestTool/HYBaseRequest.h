//
//  HYBaseRequest.h
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/3/6.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,HYRequestMethodType) {
    HYRequestMethodTypeGet,     //GET
    HYRequestMethodTypePost,    //POST
    HYRequestMethodTypePut,     //PUT
    HYRequestMethodTypeDelete,  //DELETE
    HYRequestMethodTypeHead,    //HEAD
    HYRequestMethodTypePatch,   //PATCH
};

@interface HYBaseRequest : NSObject

@property (nonatomic,strong) NSString *requestURLString;            //请求地址
@property (nonatomic,strong) id requestParameters;                  //请求参数
@property (nonatomic,assign) HYRequestMethodType requestMethodType; //请求类型
@property (nonatomic,strong) NSURLSessionDataTask *sessionDataTask; //请求任务
@property (nonatomic,assign) BOOL cache;                            //是否需要缓存
@property (nonatomic,strong) UIView *hudSuperView;                  //请求的数据的加载视图的父视图

@end
