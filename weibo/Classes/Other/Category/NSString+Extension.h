//
//  NSString+Extension.h
//  weibo
//
//  Created by afei on 16/3/6.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
@end
