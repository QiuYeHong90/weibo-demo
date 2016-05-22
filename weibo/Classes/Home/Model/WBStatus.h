//
//  WBStatus.h
//  weibo
//
//  Created by afei on 15/12/1.
//  Copyright © 2015年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUser;

@interface WBStatus : NSObject

/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的配图(数组中装模型:WBPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;
//@property (nonatomic, copy) NSString *thumbnail_pic;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博的作者
 */
@property (nonatomic, strong) WBUser *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) WBStatus *retweeted_status;

@end

/*
 {
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "text": "求关注。"，
 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
 "reposts_count": 8,
 "comments_count": 9,
 "user": {
 "id": 1404376560,
 "name": "zaku",
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 }
 }
 */
