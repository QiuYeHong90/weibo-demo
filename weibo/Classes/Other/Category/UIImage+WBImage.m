//
//  UIImage+WBImage.m
//  weibo
//
//  Created by afei on 15/11/26.
//  Copyright © 2015年 afei. All rights reserved.
//

#import "UIImage+WBImage.h"

@implementation UIImage (WBImage)

+(UIImage*)imageWithName:(NSString *)imgName{
    
    if(iOS7){
        NSString *newImgName = [imgName  stringByAppendingString:@"_os7"];
        UIImage *img = [UIImage imageNamed:newImgName];
        if(img == nil){//图片没有_os7后缀
            img = [UIImage imageNamed:imgName];
        }
        return img;
    }
    //非ios7
    return [UIImage imageNamed:imgName];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

@end
