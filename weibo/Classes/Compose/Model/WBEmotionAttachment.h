//
//  WBEmotionAttachment.h
//  weibo
//
//  Created by afei on 16/3/12.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion;

@interface WBEmotionAttachment : NSTextAttachment
@property(nonatomic,strong)WBEmotion *emotion;
@end
