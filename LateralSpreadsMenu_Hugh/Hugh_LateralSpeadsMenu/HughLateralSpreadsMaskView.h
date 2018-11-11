//
//  HughLateralSpreadsMaskView.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const HughLateralSpreadsMenuPanNoticationKey  = @"HughLateralSpreadsMenuPanNoticationKey";    //拖拽手势通知
static NSString *const HughLateralSpreadsMenuTapNoticationKey  = @"HughLateralSpreadsMenuTapNoticationKey";    //点击手势通知

@interface HughLateralSpreadsMaskView : UIView

@property (nonatomic,copy) NSArray *mainViewSubViews;

+ (instancetype)shareInstanceMaskView;

+ (void)releaseInstanceMaskView;

@end
