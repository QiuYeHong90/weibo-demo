//
//  UIImage+WBImage.h
//  weibo
//
//  Created by afei on 15/11/26.
//  Copyright © 2015年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WBImage)

/**
 *  加载图片
 *
 *  @param imgName 图片名
 *
 *  @return 加载的图片
 */
+(UIImage*) imageWithName:(NSString*)imgName;
/**
 *  返回一张自由拉伸的图片
 *
 *  @param imgName <#imgName description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*) resizedImageWithName:(NSString*)imgName;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
