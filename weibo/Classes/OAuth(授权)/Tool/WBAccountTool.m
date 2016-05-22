//
//  WBAccountTool.m
//  weibo
//
//  Created by afei on 15/11/30.
//  Copyright © 2015年 afei. All rights reserved.
//

#define WBAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "WBAccountTool.h"
#import "WBAccount.h"

@implementation WBAccountTool

+ (void)saveAccount:(WBAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:WBAccountFile];
}

+ (WBAccount *)account
{
    // 取出账号
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:WBAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) { // 还没有过期
        return account;
    } else { // 过期
        return nil;
    }
}

@end
