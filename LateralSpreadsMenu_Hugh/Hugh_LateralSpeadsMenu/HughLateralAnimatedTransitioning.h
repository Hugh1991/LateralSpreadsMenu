//
//  HughLateralAnimatedTransitioning.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HughLateralSpreadsMaskView.h"

static NSString *const HughLateralSpreadsMenuDirectionKey     = @"HughLateralSpreadsMenuDirectionKey";         //侧滑菜单滑动方向的字符串标识

typedef NS_ENUM(NSUInteger,HughLateralAnimatedTransitiontype) {
    HughLateralAnimatedTransitiontypeShow = 0,      // 显示抽屉
    HughLateralAnimatedTransitiontypeHidden         // 隐藏抽屉
};

@class HughLateralSpreadsMennuConfiguration;

@interface HughLateralAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initAnimatedTransitioning:(HughLateralAnimatedTransitiontype)transitionType configuration:(HughLateralSpreadsMennuConfiguration *)configuration;

+ (instancetype)animatedTransitioningWithType:(HughLateralAnimatedTransitiontype)transitionType configuration:(HughLateralSpreadsMennuConfiguration *)configuration;

@end

