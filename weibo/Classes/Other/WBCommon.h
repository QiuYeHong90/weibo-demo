//
//  WBCommon.h
//  weibo
//
//  Created by afei on 16/1/29.
//  Copyright © 2016年 afei. All rights reserved.
//

#define WBLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", WBAppKey, WBRedirectURI]

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得rgb颜色
#define WBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define WBRandomColor WBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 3.自定义Log
#ifdef DEBUG
#define WBLog(...) NSLog(__VA_ARGS__)
#else
#define WBLog(...)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 5.微博cell上面的属性
/** 昵称的字体 */
#define WBStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define WBRetweetStatusNameFont WBStatusNameFont

/** 时间的字体 */
#define WBStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define WBStatusSourceFont WBStatusTimeFont

/** 正文的字体 */
#define WBStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define WBRetweetStatusContentFont WBStatusContentFont

// 7.常用的对象
#define WBNotificationCenter [NSNotificationCenter defaultCenter]

// 通知
// 表情选中的通知
#define WBEmotionDidSelectNotification @"WBEmotionDidSelectNotification"
#define WBSelectEmotionKey @"WBSelectEmotionKey"
//表情键盘删除文字的通知
#define WBEmotionDidDeleteNotification @"WBEmotionDidDeleteNotification"

