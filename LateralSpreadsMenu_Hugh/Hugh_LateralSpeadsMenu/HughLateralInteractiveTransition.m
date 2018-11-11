//
//  HughLateralInteractiveTransition.m
//  LateralSpreadsMenu_Hugh
//
//  Created by Hugh on 2018/11/11.
//  Copyright © 2018年 Hugh. All rights reserved.
//

#import "HughLateralInteractiveTransition.h"
#import "HughLateralSpreadsMennuConfiguration.h"

@interface HughLateralInteractiveTransition () <UIGestureRecognizerDelegate>

@property (nonatomic,weak) UIViewController *mainVC;    //菜单控件的主视图控制器

@property (nonatomic,assign) HughLateralAnimatedTransitiontype transitionType;

@property (nonatomic,assign) HughLateralSpreadsTransitionDirection direction;   //菜单滑出的方向

@property (nonatomic,strong) CADisplayLink *displayLink;   //屏幕刷新计时器

@property (nonatomic,assign) CGFloat percent;   //手势滑动百分比

@property (nonatomic,assign) CGFloat remaincount;   //

@property (nonatomic,assign) BOOL    toFinish;  //计时器是否结束计时

@property (nonatomic,assign) CGFloat oncePercent;   //

@property (nonatomic,copy) void(^transitionDirectionBlock)(HughLateralSpreadsTransitionDirection direction);  //手势s调用菜单控件block

@end

@implementation HughLateralInteractiveTransition

+ (instancetype)initInteractiveTransitiontWithTransitiontype:(HughLateralAnimatedTransitiontype)type {
    return [[self alloc] initTransitiontWithTransitiontype:type];
}

- (instancetype)initTransitiontWithTransitiontype:(HughLateralAnimatedTransitiontype)type {
    if (self == [super init]) {
        self.transitionType = type;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hugh_singleTap) name:HughLateralSpreadsMenuTapNoticationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hugh_handleHiddenPan:) name:HughLateralSpreadsMenuPanNoticationKey object:nil];
    }
    
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController {
    self.mainVC = viewController;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hugh_handleShowPan:)];
    pan.delegate = self;
    [viewController.view addGestureRecognizer:pan];
}

#pragma mark - CADisplayLink_Getter
- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(hugh_displayLinkUpdate)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    return _displayLink;
}

#pragma mark - displayerLink
- (void)starDisplayLink {
    [self displayLink];
}

- (void)stopDisplayerLink {
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)hugh_displayLinkUpdate {
    if (self.percent >= 0.97 && self.toFinish) {
        [self stopDisplayerLink];
        [self finishInteractiveTransition];
    } else if (self.percent <= 0.03 && !self.toFinish) {
        [self stopDisplayerLink];
        [self cancelInteractiveTransition];
    } else {
        if (_toFinish) {
            self.percent += self.oncePercent;
        } else {
            self.percent -= self.oncePercent;
        }
        
        CGFloat percent = fminf(fmaxf(self.percent, 0.03), 0.97);
        [self updateInteractiveTransition:percent];
    }
}

#pragma mark - Private Method
- (void)hugh_singleTap {
    if (self.transitionType == HughLateralAnimatedTransitiontypeShow)
        return;
    
    [self.mainVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)hugh_handleHiddenPan:(NSNotification *)note {
    if (self.transitionType == HughLateralAnimatedTransitiontypeShow)
        return;
    
    UIPanGestureRecognizer *pan = note.object;
    [self handleGesture:pan];
}

- (void)hugh_handleShowPan:(UIPanGestureRecognizer *)pan {
    [self handleGesture:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)pan  {
    CGFloat x = [pan translationInView:pan.view].x;
    
    self.percent = 0;
    self.percent = x / pan.view.frame.size.width;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged: {
            
            if (!self.interacting) {
                if (self.transitionType == HughLateralAnimatedTransitiontypeShow) {
                    //判断手势拖动的位移
                    if (fabs(x) > 20) [self showBeganTranslationX:x gesture:pan];
                } else {
                    [self hiddenBeganTranslationX:x];
                }
            } else {
                self.percent = fminf(fmaxf(self.percent, 0.003), 0.97);
                [self updateInteractiveTransition:self.percent];
            }
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            self.interacting = NO;
            
            if (self.percent > self.menuConfiguration.finishPercent) {
                [self startDisplayerLink:self.percent toFinish:YES];
            } else {
                [self startDisplayerLink:self.percent toFinish:NO];
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)showBeganTranslationX:(CGFloat)x gesture:(UIPanGestureRecognizer *)pan {
    if (x >= 0)
        self.direction = HughLateralSpreadsTransitionFromLeft;
    else
        self.direction = HughLateralSpreadsTransitionFromRight;
    
    if ((x < 0 && self.direction == HughLateralSpreadsTransitionFromLeft) || (x > 0 && self.direction == HughLateralSpreadsTransitionFromRight))
        return;
    
    self.interacting = YES;
    
    if (self.transitionDirectionBlock) {
        self.transitionDirectionBlock(self.direction);
    }
}

- (void)hiddenBeganTranslationX:(CGFloat)x {
    if ((x > 0 && self.direction == HughLateralSpreadsTransitionFromLeft ) || (x < 0 && self.direction == HughLateralSpreadsTransitionFromRight ))
        return;
    
    [self.mainVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)startDisplayerLink:(CGFloat)percent toFinish:(BOOL)finish {
    if (finish && percent >= 1) {
        [self finishInteractiveTransition];
        return;
    } else if (!finish && percent <= 0) {
        [self cancelInteractiveTransition];
        return;
    }
    
    self.toFinish = finish;
    CGFloat remainDuration = finish ? self.duration * (1 - percent) : self.duration * percent;
    self.remaincount = 60 * remainDuration;
    self.oncePercent = finish ? (1 - percent) / self.remaincount : percent / self.remaincount;
    [self starDisplayLink];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL selector = @selector(hugh_gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
    if ([self.mainVC respondsToSelector:selector]) {
        IMP imp = [self.mainVC methodForSelector:selector];
        BOOL (*func)(id, SEL, UIGestureRecognizer *, UIGestureRecognizer *) = (void *)imp;
        BOOL result = func(self.mainVC, selector, gestureRecognizer, otherGestureRecognizer);
        return result;
    }
#pragma clang diagnostic pop
    // 没有实现对应方法直接走以下默认逻辑
    if ([[self viewControllerWithPanGestureView:otherGestureRecognizer.view] isKindOfClass:[UITableViewController class]]) {
        return YES;
    }
    return NO;
}

- (UIViewController *)viewControllerWithPanGestureView:(UIView *)view{
    for (UIView* next = view; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
