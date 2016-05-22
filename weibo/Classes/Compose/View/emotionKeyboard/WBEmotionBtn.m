//
//  WBEmotionBtn.m
//  weibo
//
//  Created by afei on 16/3/11.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBEmotionBtn.h"
#import "WBEmotion.h"

@implementation WBEmotionBtn

/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}
/**
 *  这个方法在initWithCoder:方法后调用
 */
-(void)awakeFromNib{

}

-(void)setUp{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    //让按钮长按不变灰色
    self.adjustsImageWhenHighlighted = NO;
}

-(void)setEmotion:(WBEmotion *)emotion{
    _emotion = emotion;
    
    if (emotion.png) { // 有图片
        [self setImage:[UIImage imageWithName:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) { // 是emoji表情
        // 设置emoji
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
