//
//  AppDelegate.h
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/2/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer NS_AVAILABLE_IOS(10);

- (void)saveContext;


@end

