//
//  WBStatusTool.h
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
////  业务处理类（工具类）

#import <Foundation/Foundation.h>
#import "WBHomeStatusesParam.h"
#import "WBHomeStatusResult.h"
#import "WBSendStatusParam.h"
#import "WBSendStatusResult.h"

@interface WBStatusTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusesWithParam:(WBHomeStatusesParam *)param success:(void (^)(WBHomeStatusResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一条微博
 */
+ (void)sendStatusWithParam:(WBSendStatusParam *)param success:(void (^)(WBSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

@end
