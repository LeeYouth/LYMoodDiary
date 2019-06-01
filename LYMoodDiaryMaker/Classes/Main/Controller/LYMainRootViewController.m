//
//  LYMainRootViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/31.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMainRootViewController.h"
#import "LYTabbarPlusButton.h"
#import "LYTabbarViewController.h"

@interface LYMainRootViewController ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@property (nonatomic, strong) LYTabbarViewController *tabBarController;

@end

@implementation LYMainRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    [LYTabbarPlusButton registerPlusButton];
    [self createNewTabBar];
}

- (CYLTabBarController *)createNewTabBar {
    LYTabbarViewController *tabBarController = [[LYTabbarViewController alloc] init];
    tabBarController.delegate = self;
    self.viewControllers = @[tabBarController];
    [tabBarController setViewDidLayoutSubViewsBlockInvokeOnce:YES block:^(CYLTabBarController *tabBarController) {
    }];
    return tabBarController;
}

#pragma mark - delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    BOOL should = YES;
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController shouldSelect:should];


    if (should && [self cyl_tabBarController].selectedIndex == viewController.cyl_tabIndex) {
//        @try {
//            [[[self class] cyl_topmostViewController] performSelector:@selector(refresh)];
//        } @catch (NSException *exception) {
//            NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), exception.reason);
//        }
    }
    return should;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    UIControl *control = [viewController cyl_tabButton];
//
//    UIView *animationView;
//    if ([control cyl_isTabButton]) {
//        //获取到tab view
//        animationView = [control cyl_tabImageView];
//    }
//    //动画
////    [self addScaleAnimationOnView:animationView repeatCount:1];
//
//    //中间按钮点击
//    if ([control cyl_isTabButton]|| [control cyl_isPlusButton]) {
//    }
    
    UIView *animationView;
    // 如果 PlusButton 也添加了点击事件，那么点击 PlusButton 后不会触发该代理方法。
    if ([control isKindOfClass:[CYLExternPlusButton class]]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    } else if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        for (UIView *subView in control.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                animationView = subView;
            }
        }
    }
    
    if ([self cyl_tabBarController].selectedIndex == 0 || [self cyl_tabBarController].selectedIndex == 1) {
        [self addScaleAnimationOnView:animationView repeatCount:1];
    }
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

@end
