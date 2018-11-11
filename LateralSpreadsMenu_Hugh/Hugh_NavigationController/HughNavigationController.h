//
//  HughNavigationController.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/10/10.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreGraphics/CGBase.h>

// 判断一个 CGSize 是否为空（宽或高为0）
CG_INLINE BOOL
CGSizeIsEmpty(CGSize size) {
    return size.width <= 0 || size.height <= 0;
}

@interface HughNavigationController : UINavigationController


/**
 导航栏背景颜色
 */
@property (nonatomic,strong) UIColor *navigationBackThemeColor;

/**
 导航栏按钮颜色
 */
@property (nonatomic,strong) UIColor *navigationTintColor;

/**
 是否隐藏返回按钮文字
 */
@property (nonatomic,assign) BOOL hiddenLeftBarText;

/**
 是否隐藏导航栏底部横线
 */
@property (nonatomic,assign) BOOL hiddenShadow;

/**
 设置导航栏标题文字颜色 && 标题字体大小

 @param titleColor 标题文字颜色
 @param titleFond 标题字体大小
 */
- (void)navigationTitleTextAttributes:(UIColor *)titleColor titleFont:(UIFont *)titleFond;

@end


