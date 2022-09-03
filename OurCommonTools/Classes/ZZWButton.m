//
//  ZZWButton.m
//  botella
//
//  Created by 周泽文 on 2018/9/28.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWButton.h"

@implementation ZZWButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(UIButton *)getLongButtonWithTitle:(NSString *)title originY:(CGFloat)y {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(16, y, ScreenWidth - 16*2, 44);
    button.layer.cornerRadius = button.frame.size.height/2;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = DefaultButtonColor;
    return button;
}

-(void)makeImageTopTitleDownWithButton:(UIButton *)button{
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height ,-button.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -button.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}
@end
