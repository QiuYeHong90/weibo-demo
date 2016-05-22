//
//  WBStatusCacheTool.h
//  weibo
//
//  Created by afei on 16/2/21.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBHomeStatusesParam.h"
@class WBStatus;

@interface WBStatusCacheTool : NSObject
/**
 *  缓存一条微博
 *
 *  @param status 需要缓存的微博数据
 */
+ (void)addStatus:(WBStatus *)status;

/**
 *  缓存N条微博
 *
 *  @param statusArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)statusArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithParam:(WBHomeStatusesParam *)param;
@end
