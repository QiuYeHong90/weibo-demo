//
//  IWCommonCheckItem.h
//  weibo
//
//  Created by afei on 16/3/6.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "IWSettingItem.h"

@interface IWCommonCheckItem : IWSettingItem

/** 标记这个item是否要打钩 */
@property (nonatomic, assign, getter = isChecked) BOOL checked;

@end
