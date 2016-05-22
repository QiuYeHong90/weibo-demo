//
//  WBEmotionTool.h
//  weibo
//
//  Created by afei on 16/3/13.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBEmotion;

@interface WBEmotionTool : NSObject
+ (void)addRecentEmotion:(WBEmotion *)emotion;
+ (NSArray *)recentEmotions;
@end
