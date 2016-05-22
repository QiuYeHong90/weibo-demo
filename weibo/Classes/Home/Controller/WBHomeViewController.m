//
//  WBHomeViewController.m
//  weibo
//
//  Created by afei on 15/11/25.
//  Copyright © 2015年 afei. All rights reserved.
//
#define WBTitleBtnDownTag 0
#define WBTitleBtnUPTag -1

#import "WBHomeViewController.h"
#import "UIBarButtonItem+WBBarBtnItem.h"
#import "WBTitleBtn.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "UIImageView+WebCache.h"

#import "WBStatus.h"
#import "WBUser.h"
#import "WBStatusFrame.h"

#import "MJExtension.h"
#import "WBStatusCell.h"
#import "MJRefresh.h"

#import "WBStatusTool.h"
#import "WBUserTool.h"


@interface WBHomeViewController () <MJRefreshBaseViewDelegate>

@property (nonatomic, weak) WBTitleBtn *titleButton;
@property (nonatomic, strong) NSMutableArray *statusFrames;

@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;


@end

@implementation WBHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 0.集成刷新控件
    [self setupRefreshView];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.获得用户信息
    [self setupUserData];
    
}
/**
 *  获得用户信息
 */
- (void)setupUserData
{
//    // 1.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [WBAccountTool account].access_token;
//    params[@"uid"] = @([WBAccountTool account].uid);
//    
//    // 2.发送请求
//    [WBHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
//        // 字典转模型
//        WBUser *user = [WBUser objectWithKeyValues:json];
//        // 设置标题文字
//        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
//        // 保存昵称
//        WBAccount *account = [WBAccountTool account];
//        account.name = user.name;
//        [WBAccountTool saveAccount:account];
//    } failure:^(NSError *error) {
//        
//    }];
    
    // 1.封装请求参数
    WBUserInfoParam *param = [WBUserInfoParam param];
    param.uid = @([WBAccountTool account].uid);
    
    // 2.发送请求
    [WBUserTool userInfoWithParam:param success:^(WBUserInfoResult *result) {
        // 设置标题文字
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        // 保存昵称
        WBAccount *account = [WBAccountTool account];
        account.name = result.name;
        [WBAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)refresh
{
    if ([self.tabBarItem.badgeValue intValue] != 0) {
        [self.header beginRefreshing];
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
    //    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
    //        IWLog(@"refreshing.....");
    //    };
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}
/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
    }
}

/**
 *  发送请求加载更多的微博数据
 */
- (void)loadMoreData
{
//    // 1.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [WBAccountTool account].access_token;
//    params[@"count"] = @5;
//    if (self.statusFrames.count) {
//        WBStatusFrame *statusFrame = [self.statusFrames lastObject];
//        // 加载ID <= max_id的微博
//        long long maxId = [statusFrame.status.idstr longLongValue] - 1;
//        params[@"max_id"] = @(maxId);
//    }

//    // 2.发送请求
//    [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
//        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
//        NSArray *statusArray = [WBStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        // 创建frame模型对象
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (WBStatus *status in statusArray) {
//            WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
//            // 传递微博模型数据
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        
//        // 添加新数据到旧数据的后面
//        [self.statusFrames addObjectsFromArray:statusFrameArray];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止显示刷新状态
//        [self.footer endRefreshing];
//    } failure:^(NSError *error) {
//        // 让刷新控件停止显示刷新状态
//        [self.footer endRefreshing];
//    }];
    
    // 1.封装请求参数
    WBHomeStatusesParam *param = [WBHomeStatusesParam param];
                                  
    param.count = @(5);
    if (self.statusFrames.count) {
        WBStatusFrame *statusFrame = [self.statusFrames lastObject];
        // 加载ID <= max_id的微博
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }
    
    // 2.发送请求
    [WBStatusTool homeStatusesWithParam:param success:^(WBHomeStatusResult *result) {
        
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (WBStatus *status in result.statuses) {
            WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 添加新数据到旧数据的后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    }];
    

}
/**
 *  // 刷新数据(向新浪获取更新的微博数据)
 */
- (void)loadNewData
{
    // 0.清除提醒数字
    self.tabBarItem.badgeValue = nil;
    
    // 1.封装请求参数
    WBHomeStatusesParam *param = [[WBHomeStatusesParam alloc] init];
    //param.count = @(5);//默认加载20条数据
    if (self.statusFrames.count) {
        WBStatusFrame *statusFrame = self.statusFrames[0];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    
    // 2.发送请求
    [WBStatusTool homeStatusesWithParam:param success:^(WBHomeStatusResult *json) {
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (WBStatus *status in json.statuses) {
            WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将最新的数据追加到旧数据的最前面
        // 旧数据: self.statusFrames
        // 新数据: statusFrameArray
        NSMutableArray *tempArray = [NSMutableArray array];
        // 添加statusFrameArray的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:statusFrameArray];
        // 添加self.statusFrames的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
        // 显示最新微博的数量(给用户一些友善的提示)
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
    
//    // 1.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [WBAccountTool account].access_token;
//    params[@"count"] = @5;
//    if (self.statusFrames.count) {
//        WBStatusFrame *statusFrame = self.statusFrames[0];
//        // 加载ID比since_id大的微博
//        params[@"since_id"] = statusFrame.status.idstr;
//    }
//    
//    // 2.发送请求
//    [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
//        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
//        NSArray *statusArray = [WBStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        // 创建frame模型对象
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (WBStatus *status in statusArray) {
//            WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
//            // 传递微博模型数据
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        
//        // 将最新的数据追加到旧数据的最前面
//        // 旧数据: self.statusFrames
//        // 新数据: statusFrameArray
//        NSMutableArray *tempArray = [NSMutableArray array];
//        // 添加statusFrameArray的所有元素 添加到 tempArray中
//        [tempArray addObjectsFromArray:statusFrameArray];
//        // 添加self.statusFrames的所有元素 添加到 tempArray中
//        [tempArray addObjectsFromArray:self.statusFrames];
//        self.statusFrames = tempArray;
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止显示刷新状态
//        [self.header endRefreshing];
//        
//        // 显示最新微博的数量(给用户一些友善的提示)
//        [self showNewStatusCount:statusFrameArray.count];
//    } failure:^(NSError *error) {
//        // 让刷新控件停止显示刷新状态
//        [self.header endRefreshing];
//    }];
}

/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(int)count
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面  btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
    }];
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    WBTitleBtn *titleButton = [WBTitleBtn titleBtn];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 0, 40);
    // 文字
    if ([WBAccountTool account].name) {
        [titleButton setTitle:[WBAccountTool account].name forState:UIControlStateNormal];
    } else {
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
    self.tableView.backgroundColor = WBColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, WBStatusTableBorder, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  切换首页导航栏中间昵称剪头小图标
 *
 *  @param titleButton 显示昵称的按钮
 */
- (void)titleClick:(WBTitleBtn *)titleButton
{
    if (titleButton.tag == WBTitleBtnUPTag) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = WBTitleBtnDownTag;
    } else {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = WBTitleBtnUPTag;
    }
}


- (void)findFriend
{
    WBLog(@"findFriend");
}

- (void)pop
{
    WBLog(@"pop");
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    // 1.创建cell
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor cyanColor];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end
