//
//  WBEmotionTabBarButton.m
//  weibo
//
//  Created by afei on 16/3/7.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBEmotionTabBarButton.h"

@implementation WBEmotionTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        // 设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    // 按钮高亮所做的一切操作都不在了
}

@end
