//
//  WBEmotionAttachment.m
//  weibo
//
//  Created by afei on 16/3/12.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBEmotionAttachment.h"
#import "WBEmotion.h"

@implementation WBEmotionAttachment

-(void)setEmotion:(WBEmotion *)emotion{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}

@end
