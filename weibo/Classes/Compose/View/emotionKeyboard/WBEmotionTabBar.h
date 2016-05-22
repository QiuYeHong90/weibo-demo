//
//  WBEmotionTabBar.h
//  weibo
//
//  Created by afei on 16/3/7.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WBEmotionTabBarButtonTypeRecent, // 最近
    WBEmotionTabBarButtonTypeDefault, // 默认
    WBEmotionTabBarButtonTypeEmoji, // emoji
    WBEmotionTabBarButtonTypeLxh, // 浪小花
} WBEmotionTabBarButtonType;

@class WBEmotionTabBar;

@protocol WBEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(WBEmotionTabBar *)tabBar didSelectButton:(WBEmotionTabBarButtonType)buttonType;

@end

@interface WBEmotionTabBar : UIView

@property (nonatomic, weak) id<WBEmotionTabBarDelegate> delegate;

@end
