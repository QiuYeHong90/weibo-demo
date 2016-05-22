//
//  UIBarButtonItem+WBBarBtnItem.m
//  weibo
//
//  Created by afei on 15/11/28.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "UIBarButtonItem+WBBarBtnItem.h"

@implementation UIBarButtonItem (WBBarBtnItem)


+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
