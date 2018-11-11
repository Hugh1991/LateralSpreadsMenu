//
//  HughNavigationController.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/10/10.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughNavigationController.h"

@interface HughNavigationController ()

@end

@implementation HughNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self == [super initWithRootViewController:rootViewController]) {
        
    }
    
    return self;
}

- (void)setNavigationBackThemeColor:(UIColor *)navigationBackThemeColor {
    [self.navigationBar setBackgroundImage:[self navigationBarBackgroundImageWithThemeColor:navigationBackThemeColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationTintColor:(UIColor *)navigationTintColor {
    self.navigationBar.tintColor = navigationTintColor;
}

- (void)setHiddenLeftBarText:(BOOL)hiddenLeftBarText {
    if (hiddenLeftBarText) {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateHighlighted];
    }
}

- (void)setHiddenShadow:(BOOL)hiddenShadow {
    if (hiddenShadow) {
        [self.navigationBar setShadowImage:[UIImage new]];
    }
}

- (void)navigationTitleTextAttributes:(UIColor *)titleColor titleFont:(UIFont *)titleFond {
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFond}];
}

#pragma mark - HughNavigationController_PrivateMethod
- (UIImage *)navigationBarBackgroundImageWithThemeColor:(UIColor *)color {
    CGSize size = CGSizeMake(4, 88);// iPhone X，navigationBar 背景图 88，所以直接用 88 的图，其他手机会取这张图在 y 轴上的 0-64 部分的图片
    color = color ? color : [UIColor clearColor];
    
    UIImage *resultImage = [self hugh_imageWithSize:size opaque:YES scale:0 actions:^(CGContextRef contextRef) {
        CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColors(spaceRef, (CFArrayRef)@[(id)color.CGColor, (id)[color hugh_colorWithAlphaAddedToWhite:0.86].CGColor], nil);
        CGContextDrawLinearGradient(contextRef, gradient, CGPointZero, CGPointMake(0, size.height), kCGGradientDrawsBeforeStartLocation);
        CGColorSpaceRelease(spaceRef);
        CGGradientRelease(gradient);
    }];
    
    return [resultImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
}

- (UIImage *)hugh_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock {
    if (!actionBlock || CGSizeIsEmpty(size)) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    actionBlock(context);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

@end
