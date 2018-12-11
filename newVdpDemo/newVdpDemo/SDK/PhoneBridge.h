//
//  PhoneBridge.h
//  CommonProject
//
//  Created by louis on 18/08/08.
//  Copyright (c) 2018年 louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneSettings.h"

@interface PhoneBridge : NSObject{
    UIBackgroundTaskIdentifier bgStartId;
    BOOL startedInBackground;
    PhoneSettings* settingsStore;
}

@property (strong, nonatomic) UIWindow *window;


+ (PhoneBridge*)shareInstance;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
//add
- (BOOL) registerSipAccount:(NSString *)username password:(NSString *)password domain:(NSString *)domain;

@end
