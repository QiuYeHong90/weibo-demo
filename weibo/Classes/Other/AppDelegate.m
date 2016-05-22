//
//  AppDelegate.m
//  weibo
//
//  Created by afei on 15/11/25.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabBarViewController.h"
#import "WBNewFeatureViewController.h"
#import "WBOAuthViewController.h"
#import "WBAccount.h"
#import "WBWeiboTool.h"
#import "WBAccountTool.h"
#import "SDWebImageManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 成为主窗口并且显示出来
    [self.window makeKeyAndVisible];
    
    // 先判断有无存储账号信息
    WBAccount *account = [WBAccountTool account];
    
    if (account) { // 之前登录成功
        [WBWeiboTool chooseRootController];
    } else { // 之前没有登录成功
        self.window.rootViewController = [[WBOAuthViewController alloc] init];
    }
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
让程序保持后台运行
1.尽量申请后台运行的时间
[application beginBackgroundTaskWithExpirationHandler:^{
    
}];

2.在Info.plist中声明自己的应用类型为audio、在后台播放mp3
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // 在后台开启任务让程序持续保持运行状态（能保持运行的时间是不确定）
    [application beginBackgroundTaskWithExpirationHandler:^{
        //        IWLog(@"过期了------");
    }];
    
    // 定时提醒（定时弹框）
    //    [UILocalNotification ];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
@end
