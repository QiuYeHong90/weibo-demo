//
//  WBHomeStatusResult.m
//  weibo
//
//  Created by afei on 16/2/15.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBHomeStatusResult.h"
#import "MJExtension.h"
#import "WBStatus.h"

@implementation WBHomeStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [WBStatus class]};
}

@end
