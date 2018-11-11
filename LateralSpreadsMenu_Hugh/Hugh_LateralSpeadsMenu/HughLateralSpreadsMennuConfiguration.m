//
//  HughLateralSpreadsMennuConfiguration.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughLateralSpreadsMennuConfiguration.h"

@implementation HughLateralSpreadsMennuConfiguration

+ (instancetype)defaultConfiguration {
    return [HughLateralSpreadsMennuConfiguration configurationWithDistance:Hugh_Screen_Width * 0.75 maskAlpha:0.4 direction:HughLateralSpreadsTransitionFromLeft];
}

- (instancetype)initWithDistance:(float)distance maskAlpha:(float)alpha direction:(HughLateralSpreadsTransitionDirection)direction {
    if (self = [super init]) {
        self.distance = distance;
        self.maskAlpha = alpha;
        self.isShowMask = YES;
        self.direction = direction;
        self.finishPercent = 0.4;
        self.showAnimDuration = 0.25;
        self.hiddenAnimDuration = 0.25;
    }
    return self;
}

+ (instancetype)configurationWithDistance:(float)distance maskAlpha:(float)alpha direction:(HughLateralSpreadsTransitionDirection)direction {
    return [[self alloc] initWithDistance:distance maskAlpha:alpha direction:direction];
}

- (float)distance {
    if (_distance <= 0)
        return Hugh_Screen_Width * 0.75;
    return _distance;
}

- (float)maskAlpha {
    if (_maskAlpha <= 0)
        return 0.4;
    return _maskAlpha;
}

- (float)finishPercent {
    if (_finishPercent <= 0)
        return 0.4;
    return _finishPercent;
}

- (NSTimeInterval)showAnimDuration {
    if (_showAnimDuration <= 0)
        return 0.25;
    
    return _showAnimDuration;
}

- (NSTimeInterval)hiddenAnimDuration {
    if (_hiddenAnimDuration <= 0)
        return 0.25;
    
    return _hiddenAnimDuration;
}

- (float)isShowMask {
    if (_isShowMask == YES)
        return _isShowMask;
    
    return _isShowMask;
}

@end
