//
//  WBBaseParam.h
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;
@end
