//
//  WBSearchBar.m
//  weibo
//
//  Created by afei on 15/11/28.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar

+(instancetype)searchBar{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        
        // 左边的放大镜图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        
        iconView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;

        // 字体
        self.font = [UIFont systemFontOfSize:11.0];
        
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置placeholder
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"发现新鲜事儿😄～" attributes:attrs];
        
        // 设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // 设置左边图标的frame
//    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
//}

@end
