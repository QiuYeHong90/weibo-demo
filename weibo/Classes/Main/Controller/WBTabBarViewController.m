//
//  WBTabBarViewController.m
//  weibo
//
//  Created by afei on 15/11/25.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBTabBarViewController.h"
#import "WBDiscoverViewController.h"
#import "WBMessageViewController.h"
#import "WBMeViewController.h"
#import "WBHomeViewController.h"
//#import "UIImage+WBImage.h"
#import "WBTabBar.h"
#import "WBNavigationController.h"
#import "WBComposeViewController.h"

#import "WBUserTool.h"
#import "WBAccountTool.h"
#import "WBAccount.h"

@interface WBTabBarViewController ()<WBTabBarDelegate>
//自定义的tabbar
@property(nonatomic,weak) WBTabBar *myTabBar;

@property (nonatomic, strong) WBHomeViewController *home;
@property (nonatomic, strong) WBMessageViewController *message;
// 3.广场
@property (nonatomic, strong) WBDiscoverViewController *discover;
// 4.我
@property (nonatomic, strong) WBMeViewController *me;

@end

@implementation WBTabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //初始化自定义tabbar
    [self setupTabBar];
    
    //初始化所有控制器
    [self setupAllChildViewController];
    
    // 定时检查未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    // 让定时器在子线程中运行
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

/**
 *  定时检查未读数
 */
- (void)checkUnreadCount
{
    //WBLog(@"be checking with five seconds...");
    // 1.请求参数
    WBUserUnreadCountParam *param = [WBUserUnreadCountParam param];
    param.uid = @([WBAccountTool account].uid);
    
    // 2.发送请求
    [WBUserTool userUnreadCountWithParam:param success:^(WBUserUnreadCountResult *result) {
        // 3.设置badgeValue
        // 3.1.首页
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        // 3.2.消息
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        // 3.3.我
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        // 4.设置图标右上角的数字
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version >= 8.0) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
        
        //WBLog(@"count are %d",result.count);
        
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  把系统自带的tabbar上的按钮删除
 *
 *  @param animated animated description
 */
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class] ]) {
            [child removeFromSuperview];
        }
    }
    
}

/**
 *  初始化自定义tabbar
 */
-(void)setupTabBar{
    WBTabBar *myTabBar = [[WBTabBar alloc]init];
    //myTabBar.backgroundColor = [UIColor redColor];
    myTabBar.frame = self.tabBar.bounds;//把tabBar的x和y为0，宽高为tabBar本身宽高赋值给自定义TabBar
    myTabBar.delegate = self;
    [self.tabBar addSubview:myTabBar];
    self.myTabBar = myTabBar;//调用属性的set方法给其赋值
}

#pragma mark - 控制器代理方法
/**
 *   监听tabbar按钮的改变
 *
 *  @param tabBar <#tabBar description#>
 *  @param from   原来选中的按钮位置
 *  @param to     现在选中的按钮位置
 */
-(void)tabBar:(WBTabBar *)tabBar didSelectedBtnFrom:(int)from to:(int)to{
    
    self.selectedIndex = to;

    NSLog(@"%d---%d",from,to);
    if (to == 0) { // 点击了首页
        [self.home refresh];
    }
}

/**
 *  监听加号按钮点击
 */
- (void)tabBarDidClickedPlusButton:(WBTabBar *)tabBar
{
    WBComposeViewController *compose = [[WBComposeViewController alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *   初始化所有子控制器
 */
-(void)setupAllChildViewController{
    
    //1. 首页
    WBHomeViewController *home = [[WBHomeViewController alloc]init];
 //   home.tabBarItem.badgeValue = @"2";
    [self initChildViewController:home navTitle:@"首页" imgName:@"tabbar_home" selectedImg:@"tabbar_home_selected"];
    self.home = home;
    
    //2. 消息
    WBMessageViewController *msg = [[WBMessageViewController alloc]init];
    //msg.tabBarItem.badgeValue = @"99+";
    [self initChildViewController:msg navTitle:@"消息" imgName:@"tabbar_message_center" selectedImg:@"tabbar_message_center_selected"];
    
    self.message = msg;
    
    //3. 发现
    WBDiscoverViewController *discover = [[WBDiscoverViewController alloc]init];
    
    [self initChildViewController:discover navTitle:@"发现" imgName:@"tabbar_discover" selectedImg:@"tabbar_discover_selected"];
    self.discover = discover;
    
    //4. 个人中心
    WBMeViewController *me = [[WBMeViewController alloc]init];
    
    [self initChildViewController:me navTitle:@"我" imgName:@"tabbar_profile" selectedImg:@"tabbar_profile_selected"];
    
    self.me = me;

}

/**
 *  初始化一个控制器
 *
 *  @param childVc     需要被初始化的子控制器
 *  @param title       头部标题
 *  @param imgName     tabbar图标
 *  @param selectedImg tabbar选中图标
 */
-(void)initChildViewController:(UIViewController *)childVc navTitle:(NSString*)navTitle  imgName:(NSString*)imgName selectedImg :(NSString*)selectedImg {
    
    // 1.设置控制器的属性
    childVc.title = navTitle;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imgName];
    // 设置选中的图标
    UIImage *selectImg = [UIImage imageWithName:selectedImg];
    
    if (iOS7) {
        //这里判断ios7主要是因为imageWithRenderingMode:在ios6没有该方法
        childVc.tabBarItem.selectedImage = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectImg;
    }
    // 2.包装一个导航控制器
    WBNavigationController *nav = [[WBNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    //3.添加自定义tabbar内部按钮
    [self.myTabBar addTabBarBtnWithItem:childVc.tabBarItem];
}

@end
