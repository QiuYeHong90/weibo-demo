//
//  WBStatusCacheTool.m
//  weibo
//
//  Created by afei on 16/2/21.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBStatusCacheTool.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBStatus.h"
#import "FMDB.h"

@implementation WBStatusCacheTool

static FMDatabaseQueue *_queue;

+ (void)setup
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, status blob);"];
    }];
}

+ (void)addStatuses:(NSArray *)statusArray
{
    for (WBStatus *status in statusArray) {
        [self addStatus:status];
    }
}

+ (void)addStatus:(WBStatus *)status
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *accessToken = [WBAccountTool account].access_token;
        NSString *idstr = status.idstr;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (access_token, idstr, status) values(?, ? , ?)", accessToken, idstr, data];
    }];
    
    [_queue close];
}

+ (NSArray *)statuesWithParam:(WBHomeStatusesParam *)param
{
    [self setup];
    
    // 1.定义数组
    __block NSMutableArray *statusArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        statusArray = [NSMutableArray array];
        
        // accessToken
        NSString *accessToken = [WBAccountTool account].access_token;
        
        FMResultSet *rs = nil;
        if (param.since_id) { // 如果有since_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", accessToken, param.since_id, param.count];
        } else if (param.max_id) { // 如果有max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
        } else { // 如果没有since_id和max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"status"];
            WBStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:status];
        }
    }];
    [_queue close];
    
    // 3.返回数据
    return statusArray;
}
@end
