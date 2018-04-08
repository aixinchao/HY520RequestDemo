//
//  HYUserManager.m
//  HYObjectRecognitionDemo
//
//  Created by BigDataAi on 2018/3/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import "HYUserManager.h"

@implementation HYUserManager

+ (HYUserManager *)sharedManager
{
    static HYUserManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *userPath = [[NSFileManager documentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",NSStringFromClass([HYUserModel class])]];
        NSString *userPermissionPath = [[NSFileManager documentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",NSStringFromClass([HYUserPermissionModel class])]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:userPath]) {
            self.userModel = [HYFileManager getObjectByFileName:NSStringFromClass([HYUserModel class])];
        }
        if ([[NSFileManager defaultManager] fileExistsAtPath:userPermissionPath]) {
            self.userPermissionModel = [HYFileManager getObjectByFileName:NSStringFromClass([HYUserPermissionModel class])];
        }
    }
    return self;
}

@end
