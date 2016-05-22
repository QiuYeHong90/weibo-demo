//
//  WBEmotionListview.m
//  weibo
//
//  Created by afei on 16/3/7.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBEmotionListview.h"
#import "WBEmotionPageView.h"

// 每一页的表情个数
//#define WBEmotionPageSize 20

@interface WBEmotionListview ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation WBEmotionListview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        //scrollView.backgroundColor = [UIColor greenColor];
        
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 当只有1页时，自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        //pageControl.backgroundColor = [UIColor redColor];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //1.pageControl的位置
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //2.scrollView的位置
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        WBEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}


// 根据emotions，创建对应个数的表情
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = (emotions.count + WBEmotionPageSize - 1) / WBEmotionPageSize;
    
    // 1.设置页数
    self.pageControl.numberOfPages = count;
    
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i<count; i++) {
        WBEmotionPageView *pageView = [[WBEmotionPageView alloc] init];
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * WBEmotionPageSize;
        // left：剩余的表情个数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if (left >= WBEmotionPageSize) { // 这一页足够20个
            range.length = WBEmotionPageSize;
        } else {
            range.length = left;
        }
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
    // 1页20个
    // 总共55个
    // 第0页：20个
    // 第1页：20个
    // 第2页：15个
    [self setNeedsLayout];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end
