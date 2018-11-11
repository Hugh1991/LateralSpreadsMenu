//
//  HughLateralAnimatedTransitioning.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughLateralAnimatedTransitioning.h"
#import "HughLateralSpreadsMennuConfiguration.h"

@interface HughLateralAnimatedTransitioning ()

@property (nonatomic,weak) HughLateralSpreadsMennuConfiguration *configuration;
@property (nonatomic,assign) HughLateralAnimatedTransitiontype transitionType;

@property (nonatomic,assign) CGFloat hiddenDelayTime;

@end

@implementation HughLateralAnimatedTransitioning

+ (instancetype)animatedTransitioningWithType:(HughLateralAnimatedTransitiontype)transitionType configuration:(HughLateralSpreadsMennuConfiguration *)configuration {
    return [[self alloc] initAnimatedTransitioning:transitionType configuration:configuration];
}

- (instancetype)initAnimatedTransitioning:(HughLateralAnimatedTransitiontype)transitionType configuration:(HughLateralSpreadsMennuConfiguration *)configuration {
    if (self = [super init]) {
        self.configuration = configuration;
        self.transitionType = transitionType;
        
        if (self.transitionType == HughLateralAnimatedTransitiontypeHidden) {
            self.hiddenDelayTime = 0;
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0)
                self.hiddenDelayTime = 0.03;
        }
    }
    
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionType == HughLateralAnimatedTransitiontypeShow ? self.configuration.showAnimDuration : self.configuration.hiddenAnimDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitionType) {
        case HughLateralAnimatedTransitiontypeShow:
            [self lateralSpreadsMenuViewShowAnimation:transitionContext];
            break;
        case HughLateralAnimatedTransitiontypeHidden:
            [self lateralSpreadsMenuViewHiddenAnimation:transitionContext];
            break;
        default:
            break;
    }
}

#pragma mark - private methods
- (void)lateralSpreadsMenuViewShowAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    HughLateralSpreadsMaskView *maskView = [HughLateralSpreadsMaskView shareInstanceMaskView];
    maskView.frame = fromVC.view.bounds;
    [fromVC.view addSubview:maskView];
    
    UIView *containerView = [transitionContext containerView];
    
    CGFloat width = self.configuration.distance;
    CGFloat x = - width;
    CGFloat ret = 1;
    
    if (self.configuration.direction == HughLateralSpreadsTransitionFromRight) {
        x = Hugh_Screen_Width;
        ret = -1;
    }
    
    toVC.view.frame = CGRectMake(x, 0, width, CGRectGetHeight(containerView.frame));
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    CGAffineTransform toVCTransiform = CGAffineTransformMakeTranslation(ret * width , 0);
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            toVC.view.transform = toVCTransiform;
            maskView.alpha = self.configuration.maskAlpha;
        }];
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:YES];
            maskView.mainViewSubViews = fromVC.view.subviews;
            [containerView addSubview:fromVC.view];
            [containerView bringSubviewToFront:toVC.view];
            maskView.userInteractionEnabled = YES;
        }else {
            [HughLateralSpreadsMaskView releaseInstanceMaskView];
            [transitionContext completeTransition:NO];
        }
    }];
}

- (void)lateralSpreadsMenuViewHiddenAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    HughLateralSpreadsMaskView *maskView = [HughLateralSpreadsMaskView shareInstanceMaskView];
    
    if (![toVC isKindOfClass:[UINavigationController class]]) {
        for (UIView *view in toVC.view.subviews) {
            if (![maskView.mainViewSubViews containsObject:view]) {
                [view removeFromSuperview];
            }
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    UIImageView *backImageView;
    if ([containerView.subviews.firstObject isKindOfClass:[UIImageView class]])
        backImageView = containerView.subviews.firstObject;
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:self.hiddenDelayTime options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1.0 animations:^{
            toVC.view.transform = CGAffineTransformIdentity;
            fromVC.view.transform = CGAffineTransformIdentity;
            maskView.alpha = 0;
            backImageView.transform = CGAffineTransformMakeScale(1.4, 1.4);
        }];
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            maskView.mainViewSubViews = nil;
            [HughLateralSpreadsMaskView releaseInstanceMaskView];
            [backImageView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
