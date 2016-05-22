//
//  WBTabBarBtn.m
//  weibo
//
//  Created by afei on 15/11/27.
//  Copyright © 2015年 afei. All rights reserved.
//

//图标的比例
#define WBTabBarBtnImgRatio 0.6
#define WBTabBarBtnTitleColor (iOS7 ? [UIColor blackColor]: [UIColor whiteColor])
#define WBTabBarBtnTitleSelectedColor (iOS7 ? WBColor(234,103,7): WBColor(248,139,0))

#import "WBTabBarBtn.h"
#import "WBBadgeBtn.h"

@interface WBTabBarBtn ()

/**
 *  提醒数字按钮
 */
@property(nonatomic,weak) WBBadgeBtn *badgeBtn;

@end


@implementation WBTabBarBtn
/**
 *   自定义按钮，初始化的时候做一些一次性的设置
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:9.0];
        [self setTitleColor:WBTabBarBtnTitleColor forState:UIControlStateNormal];
        [self setTitleColor:WBTabBarBtnTitleSelectedColor forState:UIControlStateSelected];

        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
        //添加一个badge按钮
        WBBadgeBtn *badgeBtn = [[WBBadgeBtn alloc]init];
               
        //初始化badge按钮的时候，没有frame，使用autoresizingMask
        badgeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeBtn];
        self.badgeBtn = badgeBtn;
        
    }
    return self;
}
/**
 *  长按按钮不变灰色
 *
 *  @param highlighted <#highlighted description#>
 */
-(void)setHighlighted:(BOOL)highlighted{}

/**
 *  重写tabbar原生按钮图片的布局
 *
 *  @param contentRect <#contentRect description#>
 *
 *  @return <#return value description#>
 */
-(CGRect)imageRectForContentRect:(CGRect) contentRect{
    
    CGFloat imgW = contentRect.size.width;
    CGFloat imgH = contentRect.size.height * WBTabBarBtnImgRatio;
    return CGRectMake(0, 0, imgW, imgH);
}

/**
 *  重写tabbar原生按钮title的布局
 *
 *  @param contentRect <#contentRect description#>
 *
 *  @return <#return value description#>
 */

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleY = contentRect.size.height * WBTabBarBtnImgRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

/**
 *  重写set方法
 *
 *  @param item <#item description#>
 */
-(void)setItem:(UITabBarItem *)item{
    _item = item;
 
    //KVO监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
/**
 *  释放监听
 */
-(void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}
/**
 *  监听某个对象的属性改变，若改变，就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  <#change description#>
 *  @param context <#context description#>
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    //设置提醒数字
    self.badgeBtn.badgeValue = self.item.badgeValue;
    
    CGFloat badgeBtnX = self.frame.size.width - self.badgeBtn.frame.size.width - 10;
    CGFloat badgeBtnY = 3;
    
    CGRect badgeBtnF = self.badgeBtn.frame;
    badgeBtnF.origin.x = badgeBtnX;
    badgeBtnF.origin.y = badgeBtnY;
    self.badgeBtn.frame = badgeBtnF;
    
//    //设置badge按钮
//    if (self.item.badgeValue) {
//        self.badgeBtn.hidden = NO;
//        //设置badge按钮文字
//        [self.badgeBtn setTitle:self.item.badgeValue forState:UIControlStateNormal];
//        
//        CGFloat badgeBtnY = 3;
//        CGFloat badgeBtnW = self.badgeBtn.currentBackgroundImage.size.width;
//        CGFloat badgeBtnH = self.badgeBtn.currentBackgroundImage.size.height;
//        //文字的尺寸
//        if (self.item.badgeValue.length > 1) {
//            CGSize badgeSize = [self.item.badgeValue sizeWithFont:self.badgeBtn.titleLabel.font];
//            badgeBtnW = badgeSize.width + 10 ;
//        }
//        CGFloat badgeBtnX = self.frame.size.width - badgeBtnW - 15;
//        self.badgeBtn.frame = CGRectMake(badgeBtnX, badgeBtnY, badgeBtnW, badgeBtnH);
//    }else{
//        self.badgeBtn.hidden = YES;
//    }
    
}

@end
