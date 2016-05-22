//
//  WBNavigationController.m
//  weibo
//
//  Created by afei on 15/11/28.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIBarButtonItem+WBBarBtnItem.h"


@implementation WBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreMore) name:@"moreMore" object:nil];
}

/**
 *  删除TabBar上的UITabBarButton
 */
-(void)moreMore
{
    for (UIView *tabBarButton in self.tabBarController.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"moreMore" object:nil];
}

/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme{
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置背景
    if (!iOS7) {
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowColor: [UIColor colorWithWhite:0.0f alpha:0.0f]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 0.0f)];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    
    textAttrs[NSForegroundColorAttributeName] = iOS7 ? [UIColor orangeColor] : [UIColor grayColor];
    textAttrs[NSShadowAttributeName] = shadow;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:iOS7 ? 14 : 12];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor redColor];
    
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];

   }

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme{
    
    //取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
        // 设置背景
    if (!iOS7) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowColor: [UIColor colorWithWhite:0.0f alpha:0.750f]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 0.0f)];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //设置标题属性
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    textAttrs[NSShadowAttributeName] = shadow;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];

    [navBar setTitleTextAttributes:textAttrs];
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" highIcon:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more" highIcon:@"navigationbar_more_highlighted" target:self action:@selector(more)];
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moreMore" object:nil userInfo:nil];

}

- (void)back
{
    [self popViewControllerAnimated:YES];

}


@end
