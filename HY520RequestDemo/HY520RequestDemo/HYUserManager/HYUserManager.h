//
//  HYUserManager.h
//  HYObjectRecognitionDemo
//
//  Created by BigDataAi on 2018/3/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYUserModel.h"
#import "HYUserPermissionModel.h"
#import "HYFileManager.h"

@interface HYUserManager : NSObject

/**
 *  管理用户信息的单例类 需要的情况下需要分多个类管理
 */
+ (HYUserManager *)sharedManager;

/**
 *  用户信息(用户id，姓名，年龄等信息) 修改的时候归档一下
 */
@property (nonatomic,strong) HYUserModel *userModel;

/**
 *  用户权限信息 修改的时候归档一下
 */
@property (nonatomic,strong) HYUserPermissionModel *userPermissionModel;

@end
