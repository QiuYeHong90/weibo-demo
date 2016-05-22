//
//  WBMeViewController.m
//  weibo
//
//  Created by afei on 15/11/25.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBMeViewController.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"
#import "IWSystemSettingViewController.h"

@interface WBMeViewController ()

@end

@implementation WBMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setting
{
    IWSystemSettingViewController *sys = [[IWSystemSettingViewController alloc] init];
    [self.navigationController pushViewController:sys animated:YES];
}

- (void)setupGroup0
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *newFriend = [IWSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.badgeValue = @"10";
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *album = [IWSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    IWSettingArrowItem *collect = [IWSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.badgeValue = @"2";
    IWSettingArrowItem *like = [IWSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.badgeValue = @"1";
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *pay = [IWSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    pay.subtitle = @"新年更多礼物等着你";
    IWSettingArrowItem *vip = [IWSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}

- (void)setupGroup3
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *card = [IWSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    IWSettingArrowItem *draft = [IWSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}

@end
