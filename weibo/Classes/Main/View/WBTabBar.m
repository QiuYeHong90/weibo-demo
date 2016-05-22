//
//  WBTabBar.m
//  weibo
//
//  Created by afei on 15/11/26.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarBtn.h"

@interface WBTabBar ()

@property(nonatomic,weak) WBTabBarBtn *selectBtn;
@property(nonatomic,weak) UIButton *plusBtn;
@property(nonatomic,strong) NSMutableArray *tabBarBtns;

@end

@implementation WBTabBar

- (NSMutableArray *)tabBarBtns
{
    if (_tabBarBtns == nil) {
        _tabBarBtns = [NSMutableArray array];
    }
    return _tabBarBtns;
}


/**
 *  自定义tabbar只初始化一次，给它设置背景
 *
 *  @param frame 需要被初始化的frame
 *
 *  @return 设置好背景的frame
 */
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if(!iOS7){
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        // 添加一个加号按钮
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.bounds = CGRectMake(0, 0, plusBtn.currentBackgroundImage.size.width, plusBtn.currentBackgroundImage.size.height);
        
         [plusBtn addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

- (void)plusButtonClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

-(void)addTabBarBtnWithItem:(UITabBarItem*)item{
    //1.创建按钮
    WBTabBarBtn *myTabBarBtn = [[WBTabBarBtn alloc]init];
    [self addSubview:myTabBarBtn];
    
    // 添加按钮到数组中
    [self.tabBarBtns addObject:myTabBarBtn];
    //2.设置按钮
    myTabBarBtn.item = item;
    
    //3.监听按钮
    [myTabBarBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    //4.设置默认选中按钮
    if (self.tabBarBtns.count == 1) {
        [self btnClick:myTabBarBtn];
    }
}


/**
 *  按钮点击
 *
 *  @return <#return value description#>
 */
-(void)btnClick:(WBTabBarBtn *)btn{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedBtnFrom:to:)]) {
        [self.delegate tabBar:self didSelectedBtnFrom:self.selectBtn.tag to:btn.tag];
    }
    //设置按钮的选中状态
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
}

/**
 *  重写布局子控件
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusBtn.center = CGPointMake(w * 0.5, h * 0.5);
    
    // 按钮的frame数据
    CGFloat btnH = h;
    CGFloat btnW = w / self.subviews.count;
    CGFloat btnY = 0;

    for (int idx = 0; idx<self.tabBarBtns.count; idx++) {
        //取出按钮
        WBTabBarBtn *btn = self.tabBarBtns[idx];
        CGFloat btnX = idx * btnW;
        if (idx > 1) {
            btnX += btnW;
        }
        //设置frame
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //绑定tag
        btn.tag = idx;
    }
}

@end
