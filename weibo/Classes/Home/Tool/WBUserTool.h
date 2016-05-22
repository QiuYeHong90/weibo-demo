//
//  WBUserTool.h
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserInfoParam.h"
#import "WBUserInfoResult.h"

#import "WBUserUnreadCountParam.h"
#import "WBUserUnreadCountResult.h"

@interface WBUserTool : NSObject
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(WBUserInfoParam *)param success:(void (^)(WBUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载用户的消息未读数
 */
+ (void)userUnreadCountWithParam:(WBUserUnreadCountParam *)param success:(void (^)(WBUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
