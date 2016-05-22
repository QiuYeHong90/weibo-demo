//
//  WBTabBar.h
//  weibo
//
//  Created by afei on 15/11/26.
//  Copyright © 2015年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;

@protocol WBTabBarDelegate <NSObject>

@optional

-(void)tabBar:(WBTabBar*)tabBar didSelectedBtnFrom:(int)from to:(int) to;
- (void)tabBarDidClickedPlusButton:(WBTabBar *)tabBar;

@end

@interface WBTabBar : UIView

@property(nonatomic,weak) id<WBTabBarDelegate>delegate;

/**
 *  给自定义的tabbar添加按钮及图标
 *
 *  @param item 带有待设置按钮的模型数据
 */
-(void)addTabBarBtnWithItem:(UITabBarItem*)item;


@end
