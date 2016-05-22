//
//  NSDate+WBDate.h
//  weibo
//
//  Created by afei on 16/1/23.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WBDate)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end
