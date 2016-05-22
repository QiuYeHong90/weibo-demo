//
//  WBBadgeBtn.m
//  weibo
//
//  Created by afei on 15/11/27.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBBadgeBtn.h"

@implementation WBBadgeBtn

-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:9.0];
        [self setBackgroundImage:[UIImage  resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
#warning copy
    _badgeValue = [badgeValue copy];
    //设置badge按钮
    if (badgeValue && [badgeValue intValue] != 0) {
        self.hidden = NO;
        //设置badge按钮文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGRect frame = self.frame;
        
        CGFloat badgeBtnW = self.currentBackgroundImage.size.width;
        CGFloat badgeBtnH = self.currentBackgroundImage.size.height;
        //文字的尺寸
        if (badgeValue.length > 1) {
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeBtnW = badgeSize.width + 10 ;
        }
        frame.size.width = badgeBtnW;
        frame.size.height = badgeBtnH;
        self.frame = frame;
    }else{
        self.hidden = YES;
    }
}



@end
