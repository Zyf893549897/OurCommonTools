//
//  ZZWAnimation.h
//  botella
//
//  Created by 周泽文 on 2021/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//typedef NS_ENUM(NSUInteger,ZZWAnimation_direction){
//    ZZWAnimation_Left = 1,//从左往右
//    ZZWAnimation_Right = 2//从右往左
//};

@interface ZZWAnimation : NSObject
//上下浮动的动画，可以改造外部传入动画时间和浮动幅度等
+(void)fluctuateView:(UIView *)view;


+(void)scrollView:(UIView *)view originFrame:(CGRect)originFrame endFrame:(CGRect)endFrame repeatCount:(NSInteger)count duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
