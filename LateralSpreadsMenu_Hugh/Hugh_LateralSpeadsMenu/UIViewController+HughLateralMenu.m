//
//  UIViewController+HughLateralMenu.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "UIViewController+HughLateralMenu.h"
#import <objc/runtime.h>

#import "HughLateralSpreadsMennuConfiguration.h"
#import "HughLateralTransitioning.h"

@implementation UIViewController (HughLateralMenu)

- (void)hugh_registerInteractiveTransitionWithTransitionDirectionBlock:(void(^)(HughLateralSpreadsTransitionDirection direction))transitionDirectionBlock {
    HughLateralTransitioning *lateralTransitionging = [HughLateralTransitioning initLateralTransitioningWithConfiguration:nil];
    
    objc_setAssociatedObject(self, &HughLateralTranstitioningKey, lateralTransitionging, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    HughLateralInteractiveTransition *interactiveTransition = [HughLateralInteractiveTransition initInteractiveTransitiontWithTransitiontype:HughLateralAnimatedTransitiontypeShow];
    [interactiveTransition addPanGestureForViewController:self];
    
    [interactiveTransition setValue:transitionDirectionBlock forKey:@"transitionDirectionBlock"];
    [interactiveTransition setValue:@(HughLateralSpreadsTransitionFromLeft) forKey:@"direction"];
    
    [lateralTransitionging setValue:interactiveTransition forKey:@"showIntegractiveTransiton"];
}

- (void)hugh_showLateralSpreadsMenuViewController:(UIViewController *)menuController configuration:(HughLateralSpreadsMennuConfiguration *)configuration {
    if (menuController == nil) return;
    if (configuration == nil)
        configuration = [HughLateralSpreadsMennuConfiguration defaultConfiguration];
    
    HughLateralTransitioning *lateralTransitionging = objc_getAssociatedObject(self, &HughLateralTranstitioningKey);
    
    if (lateralTransitionging == nil) {
        lateralTransitionging = [HughLateralTransitioning initLateralTransitioningWithConfiguration:configuration];
        objc_setAssociatedObject(menuController, &HughLateralTranstitioningKey, lateralTransitionging, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    menuController.transitioningDelegate = lateralTransitionging;
    
    HughLateralInteractiveTransition *interactiveTransition = [HughLateralInteractiveTransition initInteractiveTransitiontWithTransitiontype:HughLateralAnimatedTransitiontypeHidden];
    [interactiveTransition setValue:menuController forKey:@"mainVC"];
    [interactiveTransition setValue:@(configuration.direction) forKey:@"direction"];
    
    [lateralTransitionging setValue:interactiveTransition forKey:@"hiddenIntegractiveTransiton"];
    lateralTransitionging.menuConfiguration = configuration;
    
    [self presentViewController:menuController animated:YES completion:nil];
}

- (void)hugh_pushViewController:(UIViewController *)viewController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navigation;
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbar = (UITabBarController *)rootVC;
        NSInteger index = tabbar.selectedIndex;
        navigation = tabbar.childViewControllers[index];
    }else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        navigation = (UINavigationController *)rootVC;
    }else  {
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [navigation pushViewController:viewController animated:NO];
}

- (void)hugh_presentViewController:(UIViewController *)viewController {
    [self hugh_presentViewController:viewController menuViewHidden:NO];
}

- (void)hugh_presentViewController:(UIViewController *)viewController menuViewHidden:(BOOL)hidden {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    viewController.view.frame = CGRectMake(0, Hugh_Screen_Height, Hugh_Screen_Width, Hugh_Screen_Height);
    viewController.view.tag = 18557537642;
    [keyWindow addSubview:viewController.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        viewController.view.frame = CGRectMake(0, 0, Hugh_Screen_Width, Hugh_Screen_Height);
    } completion:^(BOOL finished) {
        [rootVC addChildViewController:viewController];
        if (hidden) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)hugh_dismissViewController {
    if (self.view.tag != 18557537642 && self.parentViewController.view.tag != 18557537642) {
        return;
    }
    
    UIViewController *weakSelf = self;
    if (self.parentViewController.view.tag == 18557537642) {
        weakSelf = self.parentViewController;
    }
    weakSelf.edgesForExtendedLayout = UIRectEdgeNone;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.view.frame = CGRectMake(0, Hugh_Screen_Height, Hugh_Screen_Width, Hugh_Screen_Height);
    } completion:^(BOOL finished) {
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
}

@end
