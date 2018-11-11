//
//  HughLateralTransitioning.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HughLateralAnimatedTransitioning.h"
#import "HughLateralInteractiveTransition.h"

static NSString *HughLateralTranstitioningKey = @"HughLateralTranstitioningKey";    //TransitioningDelegate代理方法执行对象的字符串标识

@class HughLateralSpreadsMennuConfiguration;
@interface HughLateralTransitioning : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) HughLateralSpreadsMennuConfiguration *menuConfiguration;


- (instancetype)initWithConfiguration:(HughLateralSpreadsMennuConfiguration *)configuration;

+ (instancetype)initLateralTransitioningWithConfiguration:(HughLateralSpreadsMennuConfiguration *)configuration;

@end
