//
//  HYFileManager.m
//  HYObjectRecognitionDemo
//
//  Created by BigDataAi on 2018/3/27.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import "HYFileManager.h"

@implementation HYFileManager

#pragma mark -- 根据fileName把对象归档到沙盒里面（Documents文件下）
+ (BOOL)saveObject:(id)object fileName:(NSString *)fileName
{
    NSString *path = [[NSFileManager documentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",fileName]];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:path];
    return success;
}

#pragma mark -- 根据fileName把沙盒里面的文件解档为对象（Documents文件下）
+ (id)getObjectByFileName:(NSString *)fileName
{
    NSString *path = [[NSFileManager documentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",fileName]];
    id obj =  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return obj;
}

#pragma mark -- 根据fileName把沙盒里面的文件删除（Documents文件下）
+ (BOOL)removeObjectByFileName:(NSString *)fileName
{
    NSString *path = [[NSFileManager documentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",fileName]];
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    return success;
}

#pragma mark ************************** 分割线(下面NSUserDefaults) **************************
#pragma mark -- 根据key存储信息到NSUserDefults
+ (BOOL)saveUserDefaultsData:(id)data forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    BOOL success = [[NSUserDefaults standardUserDefaults] synchronize];
    return success;
}

#pragma mark -- 根据key读取NSUserDefults里面的信息
+ (id)getUserDefaultsDataForKey:(NSString *)key
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return obj;
}

#pragma mark -- 根据key删除NSUserDefults里面的信息
+ (void)removeUserDefaultsForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
@end
