//
//  WBSettingCell.h
//  weibo
//
//  Created by afei on 16/2/21.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWSettingItem;

@interface WBSettingCell : UITableViewCell

@property (strong, nonatomic) IWSettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

