//
//  WBUserTool.m
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBUserTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"

@implementation WBUserTool

+ (void)userInfoWithParam:(WBUserInfoParam *)param success:(void (^)(WBUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [WBHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            WBUserInfoResult *result = [WBUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userUnreadCountWithParam:(WBUserUnreadCountParam *)param success:(void (^)(WBUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure
{
    [WBHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if (success) {
            WBUserUnreadCountResult *result = [WBUserUnreadCountResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
