//
//  HughLateralTransitioning.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughLateralTransitioning.h"

@interface HughLateralTransitioning ()

@property (nonatomic,strong) HughLateralInteractiveTransition *showIntegractiveTransiton;
@property (nonatomic,strong) HughLateralInteractiveTransition *hiddenIntegractiveTransiton;

@end

@implementation HughLateralTransitioning

- (instancetype)initWithConfiguration:(HughLateralSpreadsMennuConfiguration *)configuration {
    if (self = [super init]) {
        self.menuConfiguration = configuration;
    }
    return self;
}

+ (instancetype)initLateralTransitioningWithConfiguration:(HughLateralSpreadsMennuConfiguration *)configuration {
    return [[self alloc] initWithConfiguration:configuration];
}

- (void)setMenuConfiguration:(HughLateralSpreadsMennuConfiguration *)menuConfiguration {
    _menuConfiguration = menuConfiguration;
    
    [self.showIntegractiveTransiton setValue:menuConfiguration forKey:@"menuConfiguration"];
    [self.hiddenIntegractiveTransiton setValue:menuConfiguration forKey:@"menuConfiguration"];
}

- (void)dealloc {
    
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [HughLateralAnimatedTransitioning animatedTransitioningWithType:HughLateralAnimatedTransitiontypeShow configuration:self.menuConfiguration];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HughLateralAnimatedTransitioning animatedTransitioningWithType:HughLateralAnimatedTransitiontypeHidden configuration:self.menuConfiguration];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.showIntegractiveTransiton.interacting ? self.showIntegractiveTransiton: nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.hiddenIntegractiveTransiton.interacting ? self.hiddenIntegractiveTransiton: nil;
}

@end
