//
//  UIViewController+HughLateralMenu.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HughLateralSpreadsMennuConfiguration.h"


@interface UIViewController (HughLateralMenu)

- (void)hugh_registerInteractiveTransitionWithTransitionDirectionBlock:(void(^)(HughLateralSpreadsTransitionDirection direction))transitionDirectionBlock;

- (void)hugh_showLateralSpreadsMenuViewController:(UIViewController *)menuController configuration:(HughLateralSpreadsMennuConfiguration *)configuration;

/**
 在侧滑界面push另一个界面
 @param viewController Need to push of the controller
 */
- (void)hugh_pushViewController:(UIViewController *)viewController;

/**
 在侧滑界面present另一个界面
 @param viewController Need to present of the controller
 */
- (void)hugh_presentViewController:(UIViewController *)viewController;

/**
 在侧滑界面present另一个界面
 @param viewController Need to present of the controller
 @param hidden  The Drewer isHidden . present时抽屉是否隐藏
 */
- (void)hugh_presentViewController:(UIViewController *)viewController menuViewHidden:(BOOL)hidden;

/**
 必须要是通过hugh_presentViewController的控制器才能使用这个方法dismiss
 */
- (void)hugh_dismissViewController;

@end

