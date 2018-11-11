//
//  ViewController.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughMainViewController.h"
#import "UIViewController+HughLateralMenu.h"
#import "HughMenuViewController.h"

@interface HughMainViewController ()

@end

@implementation HughMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hugh_LateralMenu";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    Hugh_WeakSelf(weakSelf)
    
    [self hugh_registerInteractiveTransitionWithTransitionDirectionBlock:^(HughLateralSpreadsTransitionDirection direction) {
        if (direction == HughLateralSpreadsTransitionFromLeft) {
            [weakSelf hugh_showLateralSpreadsMenuViewController:[HughMenuViewController new] configuration:nil];
        }
    }];
    
    UIButton *showMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    showMenu.frame = CGRectMake(100.0, 100.0, 100.0, 40.0);
    showMenu.backgroundColor = [UIColor cyanColor];
    [showMenu setTitle:@"show menu" forState:UIControlStateNormal];
    [showMenu addTarget:self action:@selector(showMenuButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showMenu];
}

- (void)showMenuButtonAction {
    [self hugh_showLateralSpreadsMenuViewController:[HughMenuViewController new] configuration:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
