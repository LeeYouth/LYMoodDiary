//
//  LYTabbarViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/8/16.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYTabbarViewController.h"
#import "LYMoodDiaryHomePageController.h"
#import "LYGeneralViewController.h"

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
    LYMoodDiaryHomePageController *first = [[LYMoodDiaryHomePageController alloc] init];
    UIViewController *homePageVC = [[CYLBaseNavigationController alloc]
                                                   initWithRootViewController:first];

    LYGeneralViewController *second = [[LYGeneralViewController alloc] init];
    UIViewController *generalVC = [[CYLBaseNavigationController alloc]
                                                    initWithRootViewController:second];
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
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //        tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    [tabBarController rootWindow].backgroundColor = [UIColor whiteColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor] ;
    normalAttrs[NSFontAttributeName] = HPL11 ;

    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = themeButtonColor;
    selectedAttrs[NSFontAttributeName] = HPL11 ;

    // set the text Attributes
    // 设置文字属性
//    UITabBarItem *tabBar = [UITabBarItem appearance];
//    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    //     [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor: [UIColor whiteColor]];
    // [[UITabBar appearance] setBackgroundImage:[[self class] imageWithColor: [UIColor blackColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, tabBarController.tabBarHeight ?: (CYL_IS_IPHONE_X ? 65 : 40))]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    //Three way to deal with shadow 三种阴影处理方式：
    // NO.3, without shadow
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    //NO.2，using Image
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"TabBar_Bg_Shadow"]];
    //NO.1，using layer to add shadow. note:recommended. 推荐该方式，可以给PlusButton突出的部分也添加上阴影
    tabBarController.tabBar.clipsToBounds = NO;
    tabBarController.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    tabBarController.tabBar.layer.shadowRadius = 5.0;
    tabBarController.tabBar.layer.shadowOpacity = 0.2;
    tabBarController.tabBar.layer.masksToBounds = NO;
    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
}

@end
