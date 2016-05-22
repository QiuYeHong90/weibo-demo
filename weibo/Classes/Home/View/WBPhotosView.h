//
//  WBPhotosView.h
//  weibo
//
//  Created by afei on 16/1/27.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPhotosView : UIView

/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;

@end
