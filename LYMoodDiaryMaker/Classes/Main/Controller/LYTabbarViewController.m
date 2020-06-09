//
//  LYTabbarViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/8/16.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYTabbarViewController.h"

@interface LYTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation LYTabbarViewController

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetZero;
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                               tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                         imageInsets:imageInsets
                                                                             titlePositionAdjustment:titlePositionAdjustment
                                                                                             context:nil
                                             ];
    [self customizeTabBarAppearance:tabBarController];
    self.navigationController.navigationBar.hidden = YES;
//    tabBarController.delegate = self;
    return (self = (LYTabbarViewController *)tabBarController);
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    [self cyl_tabBarController].delegate = self;
    self.selectedIndex = 0;
}

- (NSArray *)viewControllers {
    UIViewController *homePageVC = [[CYLBaseNavigationController alloc]
                                                   initWithRootViewController:[[CTMediator sharedInstance] CTMediator_MoodDiaryHomePageController]];

    UIViewController *generalVC = [[CYLBaseNavigationController alloc]
                                                    initWithRootViewController:[[CTMediator sharedInstance] CTMediator_GeneralViewController]];
    [generalVC cyl_setHideNavigationBarSeparator:YES];
    
    return @[homePageVC,generalVC,];
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemImage :@"tabbar_homePage_normal",
                                                 CYLTabBarItemSelectedImage : @"tabbar_homePage_selected",

                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemImage :@"tabbar_setting_normal",
                                                  CYLTabBarItemSelectedImage : @"tabbar_setting_selected",
                                                  };
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
        
    dispatch_async(dispatch_get_main_queue(), ^{
      // Customize UITabBar height
          DKColorPicker picker = bgColor;
          DKColorPicker shadowPicker = listTitleColor;
          UIColor *barColor = picker(self.dk_manager.themeVersion);
          UIColor *shadowColor = shadowPicker(self.dk_manager.themeVersion);

          [tabBarController.tabBar setBackgroundImage:[[UIImage alloc] init]];
          [tabBarController.tabBar setBackgroundColor: barColor];
          [tabBarController.tabBar setTintColor:barColor];
          [tabBarController.tabBar setShadowImage:[UIImage new]];
          tabBarController.tabBar.clipsToBounds = NO;
          tabBarController.tabBar.layer.shadowColor = shadowColor.CGColor;
          tabBarController.tabBar.layer.shadowRadius = 5.0;
          tabBarController.tabBar.layer.shadowOpacity = 0.2;
          tabBarController.tabBar.layer.masksToBounds = NO;
          tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
        
    });
    
}

@end
