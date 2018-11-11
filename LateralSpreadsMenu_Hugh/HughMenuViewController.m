//
//  HughMenuViewController.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughMenuViewController.h"
#import "UIViewController+HughLateralMenu.h"
#import "HughPushViewController.h"
#import "HughPresentViewController.h"

@interface HughMenuViewController ()

@end

@implementation HughMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeCustom];
    push.frame = CGRectMake(100.0, 100.0, 100.0, 40.0);
    push.backgroundColor = [UIColor cyanColor];
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(pushViewControllerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
    
    UIButton *present = [UIButton buttonWithType:UIButtonTypeCustom];
    present.frame = CGRectMake(100.0, 200.0, 100.0, 40.0);
    present.backgroundColor = [UIColor cyanColor];
    [present setTitle:@"present" forState:UIControlStateNormal];
    [present addTarget:self action:@selector(presentViewControllerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:present];
}

- (void)pushViewControllerButtonAction {
    [self hugh_pushViewController:[HughPushViewController new]];
}

- (void)presentViewControllerButtonAction {
    [self hugh_presentViewController:[HughPresentViewController new]];
}


@end
