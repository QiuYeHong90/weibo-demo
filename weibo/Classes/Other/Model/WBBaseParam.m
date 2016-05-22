//
//  WBBaseParam.m
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBBaseParam.h"
#import "WBAccount.h"
#import "WBAccountTool.h"

@implementation WBBaseParam
- (id)init
{
    if (self = [super init]) {
        self.access_token = [WBAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

//- (NSString *)access_token
//{
//    if (_access_token == nil) {
//        self.access_token = [IWAccountTool account].access_token;
//    }
//    return _access_token;
//}
@end
