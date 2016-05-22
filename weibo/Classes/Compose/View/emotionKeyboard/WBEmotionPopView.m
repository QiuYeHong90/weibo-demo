//
//  WBEmotionPopView.m
//  weibo
//
//  Created by afei on 16/3/11.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBEmotionPopView.h"
#import "WBEmotionBtn.h"

@interface WBEmotionPopView ()
@property (weak, nonatomic) IBOutlet WBEmotionBtn *emotionBtn;
@end

@implementation WBEmotionPopView

+(instancetype)popView{
    return [[[NSBundle mainBundle]loadNibNamed:@"WBEmotionPopView" owner:nil options:nil ]lastObject];
}

- (void)showFrom:(WBEmotionBtn *)button
{
    if (button == nil) return;
    
    // 给popView传递数据
    self.emotionBtn.emotion = button.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
