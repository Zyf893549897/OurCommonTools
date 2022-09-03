//
//  ZZWDismiss.m
//  botella
//
//  Created by 周泽文 on 2018/10/5.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWDismiss.h"

@implementation ZZWDismiss
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    //执行的dismiss动画
    [UIView animateWithDuration:1.1 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //如果在debug中打印如下结果，是因为：动画时间是1(具体原因不明，经多次调试只要动画时间不是1就OK)
        //stiffness must be greater than 0. 刚度必须大于0;
        //damping must be greater than or equal to 0. 阻尼必须大于或等于0;
        CATransform3D fromViewTransform = fromView.layer.transform;
        fromViewTransform = CATransform3DScale(fromViewTransform, 1.5, 1.5, 1);
        
        fromView.layer.transform = fromViewTransform;
        
        fromView .alpha = 0;
        
    } completion:^(BOOL finished) {
        //
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
