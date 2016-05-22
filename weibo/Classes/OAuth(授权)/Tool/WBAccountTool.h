//
//  WBAccountTool.h
//  weibo
//
//  Created by afei on 15/11/30.
//  Copyright © 2015年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBAccount;

@interface WBAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(WBAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (WBAccount *)account;

@end
