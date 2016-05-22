//
//  WBUserUnreadCountParam.h
//  weibo
//
//  Created by afei on 16/2/16.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBBaseParam.h"

@interface WBUserUnreadCountParam : WBBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

@end
