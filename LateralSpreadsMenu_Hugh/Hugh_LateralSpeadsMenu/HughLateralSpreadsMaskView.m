//
//  HughLateralSpreadsMaskView.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughLateralSpreadsMaskView.h"

static HughLateralSpreadsMaskView *shareInstanceMaskView = nil;
static dispatch_once_t onceToken;

@implementation HughLateralSpreadsMaskView

+ (instancetype)shareInstanceMaskView {
    dispatch_once(&onceToken, ^{
        shareInstanceMaskView = [[HughLateralSpreadsMaskView alloc] init];
    });
    
    return shareInstanceMaskView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
        [self addGestureRecognizer:pan];
    }
    
    return self;
}

- (void)tapGestureRecognizerAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:HughLateralSpreadsMenuTapNoticationKey object:self];
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan {
    [[NSNotificationCenter defaultCenter] postNotificationName:HughLateralSpreadsMenuPanNoticationKey object:pan];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event { }

+ (void)releaseInstanceMaskView {
    [shareInstanceMaskView removeFromSuperview];
    onceToken = 0;
    shareInstanceMaskView = nil;
}

- (void)dealloc {
    
}

@end
