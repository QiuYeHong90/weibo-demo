//
//  WBDiscoverViewController.m
//  weibo
//
//  Created by afei on 15/11/25.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBDiscoverViewController.h"
#import "WBSearchBar.h"
#import "IWSettingGroup.h"

#import "HMOneViewController.h"
#import "HMTwoViewController.h"

#import "IWSettingItem.h"
#import "IWSettingArrowItem.h"
#import "IWSettingLabelItem.h"
#import "IWSettingSwitchItem.h"

@interface WBDiscoverViewController ()

@end

@implementation WBDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WBSearchBar *searchBar = [WBSearchBar searchBar];
    // 尺寸
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    // 设置中间的标题内容
    self.navigationItem.titleView = searchBar;
    
    // 初始化模型数据
    [self setupGroups];
    
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    IWSettingGroup *group = [IWSettingGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
    IWSettingArrowItem *hotStatus = [IWSettingArrowItem itemWithIcon:@"hot_status" title:@"热门微博"];
    hotStatus.subtitle = @"娱乐，神最右都搬到这啦";
    hotStatus.destVcClass = [HMOneViewController class];
    
    IWSettingArrowItem *findPeople = [IWSettingArrowItem itemWithIcon:@"find_people" title:@"找人"];
    findPeople.badgeValue = @"23";
    findPeople.destVcClass = [HMOneViewController class];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    IWSettingGroup *group = [IWSettingGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    IWSettingItem *gameCenter = [IWSettingArrowItem itemWithIcon:@"game_center" title:@"游戏中心" destVcClass:[HMTwoViewController class]];
    
    IWSettingItem *near = [IWSettingArrowItem itemWithIcon:@"near" title:@"周边" destVcClass:[HMTwoViewController class]];
    //near.text = @"测试文字";
    near.subtitle = @"发现附近好玩儿的";
    
    IWSettingItem *app = [IWSettingArrowItem itemWithIcon:@"app" title:@"应用" destVcClass:[HMTwoViewController class]];
    app.badgeValue = @"10";
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    IWSettingGroup *group = [IWSettingGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    IWSettingItem *video = [IWSettingItem itemWithIcon:@"video" title:@"视频"];
    video.operation = ^{
        WBLog(@"----点击了视频---");
    };
    
    IWSettingItem *music = [IWSettingSwitchItem itemWithIcon:@"music" title:@"音乐"];
    music.key = @"WBDiscoverViewController-music";
    
    IWSettingLabelItem *movie = [IWSettingLabelItem itemWithIcon:@"movie" title:@"电影"];
    movie.text = @"20:23:26";
    movie.operation = ^{
        WBLog(@"----点击了电影");
    };
    IWSettingItem *cast = [IWSettingLabelItem itemWithIcon:@"cast" title:@"播客"];
    cast.operation = ^{
        WBLog(@"----点击了播客");
    };
    cast.badgeValue = @"5";
    //cast.text = @"axxxx";
    IWSettingArrowItem *more = [IWSettingArrowItem itemWithIcon:@"more" title:@"更多"];
    more.badgeValue = @"98";
    
    group.items = @[video, music, movie, cast, more];
}

//#warning 当开始拖拽表格的时候就会调用
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    // 退出键盘
//    [self.view endEditing:YES];
//    
//    WBLog(@"invoked....");
//    
//}

@end
