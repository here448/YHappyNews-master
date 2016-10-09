//
//  AppDelegate.m
//  temp
//
//  Created by hare27 on 16/6/14.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "AppDelegate.h"
#import "HTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    HTabBarController *vc = [[HTabBarController alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


@end
