//
//  ZZWPresent.m
//  botella
//
//  Created by 周泽文 on 2018/10/5.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWPresent.h"

@implementation ZZWPresent
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //1 从过渡上下文中取出目的View 用特有的key值获取哦 (也可以先获取目标视图控制器再取出它的view)
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //2 再得到过渡的容器View 用于在动画中呈现出toView
    UIView * containerView = [transitionContext containerView];
    //toView.alpha = 0;//将目标视图加入到转场容器中使其透明
    [containerView addSubview:toView];
    
    //3 接下来设置要呈现出来的View的大小等属性
    toView.layer.cornerRadius = 20.f;
    CGRect rect = toView.frame;
    //a 使其出来的时候是从上往下
    rect.origin.y = - rect.size.height;
    //b 使其从中心位置变大到指定位置
    // 实用与collectionCell中 暂时xxx
    toView.frame = rect;
    toView.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CATransform3D toViewTransform = toView.layer.transform;
        //通过之前设置的位置或大小 等在这里改变位置 大小等来显示动画效果
        toViewTransform = CATransform3DTranslate(toViewTransform, 0, rect.size.height, 0);
        //参数的具体解释看这里哦[参数解释](http://blog.sina.com.cn/s/blog_51a995b70101mz3q.html)
        toViewTransform = CATransform3DScale(toViewTransform, 0.8, 0.5, 1);
        
        toView.layer.transform = toViewTransform;
        //toView.alpha = 1;
    } completion:^(BOOL finished) {
        //动画结束 转场结束
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
