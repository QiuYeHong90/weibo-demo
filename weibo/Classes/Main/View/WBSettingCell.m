//
//  WBSettingCell.m
//  weibo
//
//  Created by afei on 16/2/21.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBSettingCell.h"

#import "IWSettingItem.h"
#import "IWSettingArrowItem.h"
#import "IWSettingSwitchItem.h"
#import "IWSettingLabelItem.h"
#import "IWCommonCheckItem.h"

#import "WBBadgeBtn.h"

@interface WBSettingCell ()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *switchView;
/**
 *  打钩
 */
@property (strong, nonatomic) UIImageView *rightCheck;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;
/**
 *  提醒数字
 */
@property (strong, nonatomic) WBBadgeBtn *badgeButton;

/** 存取UITableView*/
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *selectedBgView;

@end


@implementation WBSettingCell

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
         [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

/**
 *  监听开关状态改变
 */
- (void)switchStateChange
{
    WBLog(@"%@ switch %d",self.item.title,self.switchView.isOn);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.item.key) {
     [defaults setBool:self.switchView.isOn forKey:self.item.key];
    }else{
        [defaults setBool:self.switchView.isOn forKey:self.item.title];
    }
    [defaults synchronize];
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (WBBadgeBtn *)badgeButton
{
    if (_badgeButton == nil) {
        _badgeButton = [[WBBadgeBtn alloc] init];
    }
    return _badgeButton;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.bounds = CGRectMake(0, 0, 80, 30);
        //_rightLabel.backgroundColor = WBRandomColor;
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.font = [UIFont systemFontOfSize:11];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

- (UIImageView *)rightCheck
{
    if (_rightCheck == nil) {
        self.rightCheck = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_checkmark"]];
    }
    return _rightCheck;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    WBSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WBSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        //把传进来的tableView存放到cell的tableView上
        cell.tableView = tableView;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 创建背景
        UIImageView *bgView = [[UIImageView alloc] init];
        self.backgroundView = bgView;
        self.bgView = bgView;
        
        UIImageView *selectedBgView = [[UIImageView alloc] init];
        self.selectedBackgroundView = selectedBgView;
        self.selectedBgView = selectedBgView;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (iOS7) {
        frame.origin.x = 5;
        frame.size.width -= 10;
    }
    [super setFrame:frame];
}

- (void)setItem:(IWSettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的控件
    [self setupRightView];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    //看某组有多少行cell
    NSInteger totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
    
    NSString *bgName = nil;
    NSString *selectedBgName = nil;
    
    if (totalRows == 1) { // 这组就1行
        bgName = @"common_card_background";
        selectedBgName = @"common_card_background_highlighted";
    } else if (indexPath.row == 0) { // 首行
        bgName = @"common_card_top_background";
        selectedBgName = @"common_card_top_background_highlighted";
    } else if (indexPath.row == totalRows - 1) { // 尾行
        bgName = @"common_card_bottom_background";
        selectedBgName = @"common_card_bottom_background_highlighted";
    } else { // 中行
        bgName = @"common_card_middle_background";
        selectedBgName = @"common_card_middle_background_highlighted";
    }
    self.bgView.image = [UIImage resizedImageWithName:bgName];
    self.selectedBgView.image = [UIImage resizedImageWithName:selectedBgName];
}

/**
 *  设置数据
 */
- (void)setupData
{
    // 1.图标
    if (self.item.icon) {
        self.imageView.image = [UIImage imageWithName:self.item.icon];
    }
    
    // 2.标题
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subtitle;
}

/**
 *  设置右边的控件
 */
- (void)setupRightView
{
    if (self.item.badgeValue) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    } else if ([self.item isKindOfClass:[IWSettingSwitchItem class]]){ // 右边是开关
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置开关的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      if (self.item.key) {
          self.switchView.on = [defaults boolForKey:self.item.key];
      }else{
          self.switchView.on = [defaults boolForKey:self.item.title];
      }
        
    }else if ([self.item isKindOfClass:[IWSettingArrowItem class]]){ // 右边是箭头
        self.accessoryView = self.arrowView;
        
    }else if ([self.item isKindOfClass:[IWSettingLabelItem class]]) {
        // 显示label
        self.accessoryView = self.rightLabel;
        
        // 设置label的文字
        IWSettingLabelItem *labelItem = (IWSettingLabelItem *)self.item;
        self.rightLabel.text = labelItem.text;
        
        // 计算尺寸
       // self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font];
    }else if ([self.item isKindOfClass:[IWCommonCheckItem class]]) {// 显示打钩
        
        IWCommonCheckItem *checkItem = (IWCommonCheckItem *)self.item;
        if (checkItem.isChecked) {
            self.accessoryView = self.rightCheck;
        }
    } else { // 右边没有东西
        self.accessoryView = nil;
    }
}

@end
