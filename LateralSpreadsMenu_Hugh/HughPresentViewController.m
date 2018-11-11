//
//  HughPresentViewController.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughPresentViewController.h"
#import "UIViewController+HughLateralMenu.h"

@interface HughPresentViewController ()

@end

@implementation HughPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"present";
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hugh_dismissViewController];
}

@end
