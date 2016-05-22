//
//  WBEmotion.m
//  weibo
//
//  Created by afei on 16/3/7.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBEmotion.h"
#import "MJExtension.h"

@interface WBEmotion ()<NSCoding>

@end

@implementation WBEmotion

MJCodingImplementation
/**
 *  常用来比较两个HWEmotion对象是否一样
 *
 *  @param other 另外一个HWEmotion对象
 *
 *  @return YES : 代表2个对象是一样的，NO: 代表2个对象是不一样
 */
- (BOOL)isEqual:(WBEmotion *)other
{
    //    if (self == other) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    
    //    HWLog(@"%@--isEqual---%@", self.chs, other.chs);
    
    //    NSString *str1 = @"jack";
    //    NSString *str2 = [NSString stringWithFormat:@"jack"];
    //
    //    str1 == str2 // no
    //    [str1 isEqual:str2]; // NO
    //    [str1 isEqualToString:str2] // YES
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}

@end
