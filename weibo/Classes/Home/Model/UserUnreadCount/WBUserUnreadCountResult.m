//
//  WBUserUnreadCountResult.m
//  weibo
//
//  Created by afei on 16/2/16.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBUserUnreadCountResult.h"

@implementation WBUserUnreadCountResult

- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}

@end
