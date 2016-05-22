//
//  WBEmotionKeyboard.m
//  weibo
//
//  Created by afei on 16/3/7.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBEmotionKeyboard.h"
#import "WBEmotionListview.h"
#import "WBEmotionTabBar.h"
#import "WBEmotion.h"
#import "MJExtension.h"
#import "WBEmotionTool.h"

@interface WBEmotionKeyboard ()<WBEmotionTabBarDelegate>

/** 容纳表情内容的控件 */
@property (nonatomic, weak) UIView *contentView;
/** 表情内容 */
@property (nonatomic, strong) WBEmotionListview *recentListview;
@property (nonatomic, strong) WBEmotionListview *defaultListView;
@property (nonatomic, strong) WBEmotionListview *emojiListView;
@property (nonatomic, strong) WBEmotionListview *lxhListView;
/** tabbar */
@property (nonatomic, weak) WBEmotionTabBar *tabBar;

@end

@implementation WBEmotionKeyboard


#pragma mark - 懒加载

- (WBEmotionListview *)recentListView
{
    if (!_recentListview) {
        self.recentListview = [[WBEmotionListview alloc] init];
        // 加载沙盒中的数据
        self.recentListview.emotions = [WBEmotionTool recentEmotions];
    }
    return _recentListview;
}

- (WBEmotionListview *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[WBEmotionListview alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"defaultInfo.plist" ofType:nil];
        self.defaultListView.emotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        //self.defaultListView.backgroundColor = WBRandomColor;
    }
    return _defaultListView;
}

- (WBEmotionListview *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[WBEmotionListview alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emojiInfo.plist" ofType:nil];
        self.emojiListView.emotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        //self.emojiListView.backgroundColor = WBRandomColor;
    }
    return _emojiListView;
}

- (WBEmotionListview *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[WBEmotionListview alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lxhInfo.plist" ofType:nil];
        self.lxhListView.emotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        //self.lxhListView.backgroundColor = WBRandomColor;
    }
    return _lxhListView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.contentView
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        // 2.tabbar
        WBEmotionTabBar *tabBar = [[WBEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 表情选中的通知
        [WBNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:WBEmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)emotionDidSelect
{
    self.recentListView.emotions = [WBEmotionTool recentEmotions];
}

- (void)dealloc
{
    [WBNotificationCenter removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.contentView.x = self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
    
    // 3.设置frame
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
}

#pragma mark - HWEmotionTabBarDelegate

- (void)emotionTabBar:(WBEmotionTabBar *)tabBar didSelectButton:(WBEmotionTabBarButtonType)buttonType
{
    // 移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 根据按钮类型，切换contentView上面的listview
    switch (buttonType) {
            
        case WBEmotionTabBarButtonTypeRecent: { // 最近
            [self.contentView addSubview:self.recentListview];
            break;
        }
            
        case WBEmotionTabBarButtonTypeDefault: { // 默认
            [self.contentView addSubview:self.defaultListView];
            //WBLog(@"%@", _defaultListView.emotions);
            break;
        }
            
        case WBEmotionTabBarButtonTypeEmoji: { // Emoji
            [self.contentView addSubview:self.emojiListView];
           // WBLog(@"%@", _emojiListView.emotions);

            break;
        }
            
        case WBEmotionTabBarButtonTypeLxh: { // Lxh
            [self.contentView addSubview:self.lxhListView];
            //WBLog(@"%@", _lxhListView.emotions);
            
            break;
        }
    }
    
    // 重新计算子控件的frame(setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件)
    [self setNeedsLayout];
    //    UIView *child = [self.contentView.subviews lastObject];
    //    child.frame = self.contentView.bounds;
}

@end
