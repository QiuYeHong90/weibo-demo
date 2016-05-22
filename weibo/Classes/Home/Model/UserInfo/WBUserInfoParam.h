//
//  WBUserInfoParam.h
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBBaseParam.h"

@interface WBUserInfoParam : WBBaseParam
/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;
@end
