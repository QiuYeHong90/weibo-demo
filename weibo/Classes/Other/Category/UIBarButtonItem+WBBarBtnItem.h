//
//  UIBarButtonItem+WBBarBtnItem.h
//  weibo
//
//  Created by afei on 15/11/28.
//  Copyright © 2015年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WBBarBtnItem)

/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
