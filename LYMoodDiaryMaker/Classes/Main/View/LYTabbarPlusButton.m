//
//  LYTabbarPlusButton.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/30.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYTabbarPlusButton.h"

@implementation LYTabbarPlusButton

+ (id)plusButton {
    LYTabbarPlusButton *button = [[LYTabbarPlusButton alloc] init];
    UIImage *normalButtonImage = [UIImage imageNamed:@"tabbar_addMood_normal"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"tabbar_addMood_normal"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:hlightButtonImage forState:UIControlStateHighlighted];
    [button setImage:hlightButtonImage forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    button.frame = CGRectMake(0.0, 0.0, 74, 70);
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
//    id <LYWriteMoodDiaryViewProtocol> obj = [[BeeHive shareInstance] createService:@protocol(LYWriteMoodDiaryViewProtocol)];
//    if ([obj isKindOfClass:[UIViewController class]]) {
//        [viewController presentViewController:(UIViewController *)obj animated:YES completion:nil];
//    }
}

#pragma mark - CYLPlusButtonSubclassing

//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 1;
//}

//+ (BOOL)shouldSelectPlusChildViewController {
//    BOOL isSelected = CYLExternPlusButton.selected;
//    if (isSelected) {
//        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
//    } else {
//        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
//    }
//    return YES;
//}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 2 : 4);
}

//+ (NSString *)tabBarContext {
//    return NSStringFromClass([self class]);
//}

@end
