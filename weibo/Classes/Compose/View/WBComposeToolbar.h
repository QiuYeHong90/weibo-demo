//
//  WBComposeToolbar.h
//  weibo
//
//  Created by afei on 16/2/13.
//  Copyright © 2016年 afei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBComposeToolbar;

typedef enum {
    WBComposeToolbarButtonTypeCamera,
    WBComposeToolbarButtonTypePicture,
    WBComposeToolbarButtonTypeMention,
    WBComposeToolbarButtonTypeTrend,
    WBComposeToolbarButtonTypeEmotion
} WBComposeToolbarButtonType;

@protocol WBComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(WBComposeToolbar *)toolbar didClickedButton:(WBComposeToolbarButtonType)buttonType;
@end

@interface WBComposeToolbar : UIView

@property (weak, nonatomic) id<WBComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;

@end

