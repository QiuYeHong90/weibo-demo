//
//  WBOAuthViewController.m
//  weibo
//
//  Created by afei on 15/11/30.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBWeiboTool.h"
#import "WBHttpTool.h"

@interface WBOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面(新浪提供的登录页面)
    NSURL *url = [NSURL URLWithString:WBLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - webView代理方法
/**
 *  webView开始发送请求的时候就会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"加载中..."];
}

/**
 *  webView请求完毕的时候就会调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}
/**
 *  webView请求失败的时候就会调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 *
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.请求的URL路径: http://app.scitc.com.cn/qihang/?code=b999e59442bb2583c3dc737d2f9e797f
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含了code=
    //    if (range.location != NSNotFound)
    if (range.length) {
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 5.发送POST请求给新浪,  通过code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 不加载这个请求
        return NO;
    }
    
    return YES;
}

/**
 *  通过code换取一个accessToken
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = WBAppKey;
    params[@"client_secret"] = WBAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = WBRedirectURI;
    
    // 2.发送请求
    [WBHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        // 4.先将字典转为模型
        WBAccount *account = [WBAccount accountWithDict:json];
        
        // 5.存储模型数据
        [WBAccountTool saveAccount:account];
        
        // 6.新特性\去首页
        [WBWeiboTool chooseRootController];
        
        // 7.隐藏提醒框
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
    }];
}

@end
