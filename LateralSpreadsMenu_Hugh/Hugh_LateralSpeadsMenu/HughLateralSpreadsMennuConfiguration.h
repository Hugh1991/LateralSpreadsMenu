//
//  HughLateralSpreadsMennuConfiguration.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HughLateralSpreadsMennuConfiguration : NSObject

typedef NS_ENUM(NSUInteger,HughLateralSpreadsTransitionDirection) {
    HughLateralSpreadsTransitionFromLeft = 0, // 左侧滑出
    HughLateralSpreadsTransitionFromRight     // 右侧滑出
};

/**
 根控制器可偏移的距离，默认为屏幕的0.75
 */
@property (nonatomic,assign) float distance;

/**
 手势驱动动画完成的临界点（范围0 - 1.0），默认为0.5（表示手势驱动到动画的一半则执行完动画，拖动不到一半则会取消动画）
 */
@property (nonatomic,assign) float finishPercent;

/**
 抽屉显示动画的持续时间，默认为0.25f
 */
@property (nonatomic,assign) NSTimeInterval showAnimDuration;

/**
 抽屉隐藏动画的持续时间，默认为0.25f
 */
@property (nonatomic,assign) NSTimeInterval hiddenAnimDuration;

/**
 遮罩的透明度
 */
@property (nonatomic,assign) float maskAlpha;


/**
 是否显示遮罩图层 默认不显示
 */
@property (nonatomic,assign) float isShowMask;

/**
 菜单滑出的方向，默认为从左侧滑出
 */
@property (nonatomic,assign) HughLateralSpreadsTransitionDirection direction;


/*---------------------------------------------- 声明侧滑菜单配置方法 ----------------------------------------------*/


/**
 默认配置
 
 @return 配置对象本身
 */
+ (instancetype)defaultConfiguration;

/**
 创建一个配置对象的实例方法
 
 @param distance 偏移距离
 @param alpha 遮罩的透明度
 @param direction 滑出方向
 @return 配置对象本身
 */
- (instancetype)initWithDistance:(float)distance maskAlpha:(float)alpha direction:(HughLateralSpreadsTransitionDirection)direction;

/**
 创建一个配置对象的类方法
 
 @param distance 偏移距离
 @param alpha 遮罩的透明度
 @param direction 滑出方向
 @return 配置对象本身
 */
+ (instancetype)configurationWithDistance:(float)distance maskAlpha:(float)alpha direction:(HughLateralSpreadsTransitionDirection)direction;


@end

