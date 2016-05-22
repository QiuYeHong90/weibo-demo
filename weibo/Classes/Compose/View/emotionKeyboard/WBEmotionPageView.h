//
//  WBEmotionPageView.h
//  weibo
//
//  Created by afei on 16/3/9.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define WBEmotionMaxRows 3
// 一行中最多7列
#define WBEmotionMaxCols 7
// 每一页的表情个数
#define WBEmotionPageSize ((WBEmotionMaxRows * WBEmotionMaxCols) - 1)

@interface WBEmotionPageView : UIView
/** 这一页显示的表情（里面都是HWEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;
@end
