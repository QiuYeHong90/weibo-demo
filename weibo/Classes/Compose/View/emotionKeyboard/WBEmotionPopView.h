//
//  WBEmotionPopView.h
//  weibo
//
//  Created by afei on 16/3/11.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion,WBEmotionBtn;

@interface WBEmotionPopView : UIView

@property(nonatomic,strong)WBEmotion *emotion;

+(instancetype)popView;
- (void)showFrom:(WBEmotionBtn *)button;
@end
