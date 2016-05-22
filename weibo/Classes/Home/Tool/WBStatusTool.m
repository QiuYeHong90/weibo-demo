//
//  WBStatusTool.m
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"
#import "WBStatusCacheTool.h"

@implementation WBStatusTool

+ (void)homeStatusesWithParam:(WBHomeStatusesParam *)param success:(void (^)(WBHomeStatusResult *))success failure:(void (^)(NSError *))failure
{
//    [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
//        if (success) {
//            WBHomeStatusResult *result = [WBHomeStatusResult objectWithKeyValues:json];
//            success(result);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    // 1.先从缓存里面加载
    NSArray *statusArray = [WBStatusCacheTool statuesWithParam:param];
    if (statusArray.count) { // 有缓存
        // 传递了block
        if (success) {
            WBHomeStatusResult *result = [[WBHomeStatusResult alloc] init];
            result.statuses = statusArray;
            success(result);
        }
    } else {
        [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
            WBHomeStatusResult *result = [WBHomeStatusResult objectWithKeyValues:json];
            
            // 缓存
            [WBStatusCacheTool addStatuses:result.statuses];
            
            // 传递了block
            if (success) {
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

+ (void)sendStatusWithParam:(WBSendStatusParam *)param success:(void (^)(WBSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [WBHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            WBSendStatusResult *result = [WBSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
