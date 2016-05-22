//
//  WBEmotionTool.m
//  weibo
//
//  Created by afei on 16/3/13.
//  Copyright © 2016年 afei. All rights reserved.
//

// 最近表情的存储路径
#define WBRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "WBEmotionTool.h"
#import "WBEmotion.h"

@implementation WBEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:WBRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)addRecentEmotion:(WBEmotion *)emotion
{
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    
    // 将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:WBRecentEmotionsPath];
}

/**
 *  返回装着HWEmotion模型的数组
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}
@end
