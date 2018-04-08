//
//  NSFileManager+Paths.h
//  HYNeiHan
//
//  Created by 上官惠阳 on 16/9/25.
//  Copyright © 2016年 上官惠阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Paths)
/**
 获取Documents文件夹的URL.

 @return 返回Documents的URL.
 */
+ (NSURL *)documentsURL;

/**
 获取Documents文件夹的路径.

 @return Documents的路径.
 */
+ (NSString *)documentsPath;

/**
 获取Library文件夹的URL.

 @return Library的URL.
 */
+ (NSURL *)libraryURL;

/**
获取Library文件夹的路径.
 
 @return Library的路径.
 */
+ (NSString *)libraryPath;

/**
 获取Caches文件夹的URL.

 @return Caches的URL.
 */
+ (NSURL *)cachesURL;

/**
获取Caches文件夹的路径.
 
 @return Caches的路径.
 */
+ (NSString *)cachesPath;

/**
 添加一个特殊的文件系统标记文件,以避免iCloud备份.

 @param path 文件路径.
 */
+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path;

/**
可用磁盘空间.

 @return 兆字节的数量的可用磁盘空间.
 */
+ (double)availableDiskSpace;
@end
