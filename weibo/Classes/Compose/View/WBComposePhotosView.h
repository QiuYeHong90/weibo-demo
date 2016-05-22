//
//  WBComposePhotosView.h
//  weibo
//
//  Created by afei on 16/2/14.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBComposePhotosView : UIView
/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 */
- (NSArray *)totalImages;
@end
