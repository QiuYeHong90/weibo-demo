//
//  WBEmotionTextView.h
//  weibo
//
//  Created by afei on 16/3/11.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBTextView.h"
@class WBEmotion;

@interface WBEmotionTextView : WBTextView
- (void)insertEmotion:(WBEmotion *)emotion;
/**获取发微博输入框的所有文字（即包括表情图片的对应文字描述）*/
- (NSString *)fullText;

@end
