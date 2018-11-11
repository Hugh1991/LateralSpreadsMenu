//
//  HughTool.h
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/10/29.
//  Copyright © 2018年 hugh. All rights reserved.
//

#ifndef HughTool_h
#define HughTool_h

#import "UIColor+HughColor.h"

#define Hugh_WeakSelf(weakSelf) __weak typeof(self) weakSelf = self;

#define Hugh_SystemVersion          [UIDevice currentDevice].systemVersion
#define Hugh_Application            [UIApplication sharedApplication]
#define Hugh_Application_Window     [[[UIApplication sharedApplication] delegate] window]

#define Hugh_NavigationBar_Height 44.0
#define Hugh_StatusBar_Height 20.0

#define Hugh_Screen_Height          [[UIScreen mainScreen] bounds].size.height
#define Hugh_Screen_Width           [[UIScreen mainScreen] bounds].size.width

#define Hugh_ColorMake(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define Hugh_ColorMakeWithRGBA(r, g, b, a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#define Hugh_RandomColor            Hugh_ColorMake(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define Hugh_RGBHex(rgbValue)           [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define Hugh_RGBHexAlpha(rgbValue,a)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#ifdef DEBUG
    #define HughLog(fmt,...) NSLog((@"%s [gLine %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define HughLog(...)
#endif


#endif 
