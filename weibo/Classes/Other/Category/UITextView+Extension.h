//
//  UITextView+Extension.h
//  weibo
//
//  Created by afei on 16/3/11.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
