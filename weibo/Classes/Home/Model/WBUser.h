//
//  WBUser.h
//  weibo
//
//  Created by afei on 15/12/1.
//  Copyright © 2015年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;

@end

/*
 {
 "id": 1404376560,
 "name": "zaku",
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 }
 */