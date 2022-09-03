//
//  ZZWAnimation.m
//  botella
//
//  Created by 周泽文 on 2021/12/22.
//

#import "ZZWAnimation.h"

@implementation ZZWAnimation
+(void)fluctuateView:(UIView *)view{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat duration = 2.0f;
    CGFloat height = 7.f;
    CGFloat currentY = view.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentY),@(currentY - height/4),@(currentY - height/4*2),@(currentY - height/4*3),@(currentY - height),@(currentY - height/ 4*3),@(currentY - height/4*2),@(currentY - height/4),@(currentY)];
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    [view.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}

+(void)scrollView:(UIView *)view
      originFrame:(CGRect)originFrame
         endFrame:(CGRect)endFrame
      repeatCount:(NSInteger)count
         duration:(CGFloat)duration{
    view.frame = originFrame;
    
    [UIView beginAnimations:nil context:NULL];
    if (duration > 0) {
        [UIView setAnimationDuration:duration];
    }else{
        [UIView setAnimationDuration:5.0];
    }
    
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:NO];
    if (count > 0) {
        [UIView setAnimationRepeatCount:count];
    }else{
        [UIView setAnimationRepeatCount:MAXFLOAT];
        
    }
    
    
    view.frame = endFrame;
    
    [UIView commitAnimations];
}
@end
