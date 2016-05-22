//
//  WBStatusCell.h
//  weibo
//
//  Created by afei on 16/1/22.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusFrame;

@interface WBStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) WBStatusFrame *statusFrame;

@end
