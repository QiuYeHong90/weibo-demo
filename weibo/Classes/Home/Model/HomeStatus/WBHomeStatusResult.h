//
//  WBHomeStatusResult.h
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
////  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface WBHomeStatusResult : NSObject
/**
 *  statuses数组里面放的都是IWStatus模型
 */
@property (nonatomic, strong) NSArray *statuses;//让该数组中存放status(微博)模型，WBHomeStatusResult.m中实现了该方法

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;
@end
