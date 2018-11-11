//
//  HughLateralInteractiveTransition.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HughLateralAnimatedTransitioning.h"

@class HughLateralSpreadsMennuConfiguration;

@interface HughLateralInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,strong) HughLateralSpreadsMennuConfiguration *menuConfiguration;
@property (nonatomic,assign) BOOL interacting; //手势滑动是否正在进行中

+ (instancetype)initInteractiveTransitiontWithTransitiontype:(HughLateralAnimatedTransitiontype)type;
- (instancetype)initTransitiontWithTransitiontype:(HughLateralAnimatedTransitiontype)type;

- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
