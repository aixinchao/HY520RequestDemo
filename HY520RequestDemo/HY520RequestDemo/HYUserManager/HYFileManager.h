//
//  HYFileManager.h
//  HYObjectRecognitionDemo
//
//  Created by BigDataAi on 2018/3/27.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+Paths.h"

@interface HYFileManager : NSObject

/**
 *  根据fileName把对象归档到沙盒里面（Documents文件下）
 *
 *  @param fileName 文件名
 */
+ (BOOL)saveObject:(id)object fileName:(NSString *)fileName;

/**
 *  根据fileName把沙盒里面的文件解档为对象（Documents文件下）
 *
 *  @param fileName 文件名
 */
+ (id)getObjectByFileName:(NSString *)fileName;

/**
 *  根据fileName把沙盒里面的文件删除（Documents文件下）
 *
 *  @param fileName 文件名
 */
+ (BOOL)removeObjectByFileName:(NSString *)fileName;

/**
 *  根据key存储信息到NSUserDefults
 *
 *  @param key 键
 */
+ (BOOL)saveUserDefaultsData:(id)data forKey:(NSString *)key;

/**
 *  根据key读取NSUserDefults里面的信息
 *
 *  @param key 键
 */
+ (id)getUserDefaultsDataForKey:(NSString *)key;

/**
 *  根据key删除NSUserDefults里面的信息
 *
 *  @param key 键
 */
+ (void)removeUserDefaultsForKey:(NSString *)key;

@end
