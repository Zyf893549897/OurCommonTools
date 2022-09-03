//
//  ZZWButton.h
//  botella
//
//  Created by 周泽文 on 2018/9/28.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZWButton : UIButton

/**
 获取长条形风格的button

 @param title 标题
 @param y 距离顶部的高度
 @return 按钮
 */
+(UIButton *)getLongButtonWithTitle:(NSString *)title originY:(CGFloat)y ;
@end
