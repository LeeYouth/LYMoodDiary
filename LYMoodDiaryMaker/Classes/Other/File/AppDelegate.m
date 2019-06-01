//
//  AppDelegate.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/8/16.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+UMSocial.h"
#import "LYMoodDiaryHomePageController.h"
#import "LYBaseNavigationController.h"
#import "LYHomePageViewController.h"
#import "LYMainRootViewController.h"
#import "LYCustomPasscodeViewController.h"

@interface AppDelegate ()<LYPasscodeViewControllerDelegate>

@property (nonatomic, strong) LYCustomPasscodeViewController *passcodeVC;
@property (nonatomic, strong) LYMainRootViewController *mainRootVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (iOS11) {
        if (@available(iOS 11.0, *)) {
            [UIScrollView appearance].
            contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
#warning - 在这里配置正式、测试，log开关
    //配置服务器类型
    [LYServerConfig setLYConfigEnv:LYServerEnvDevelop];
    self.window = [[UIWindow alloc] init];
    
    
    self.mainRootVC = [[LYMainRootViewController alloc] init];
    
    self.passcodeVC = [[LYCustomPasscodeViewController alloc] initWithNibName:nil bundle:nil];
    self.passcodeVC.delegate = self;
    self.passcodeVC.type = LYPasscodeViewControllerCheckPasscodeType;
    self.passcodeVC.passcodeStyle = LYPasscodeInputViewNormalPasscodeStyle;
    LYTouchIDManager *touchIDManager = [[LYTouchIDManager alloc] initWithKeychainServiceName:LYPasscodeKeychainServiceName];
    touchIDManager.promptText = @"BKPasscodeView Touch ID Demo";
    self.passcodeVC.touchIDManager = touchIDManager;
    
    [self.passcodeVC startTouchIDAuthenticationIfPossible:^(BOOL prompted) {
        if (prompted) {
            
        } else {

        }
    }];
    
    //设置了密码
    if ([LYPasscodeManager passcodeSwitchOn] && [LYPasscodeManager hasSetPasscode]) {
        [self.window setRootViewController:self.passcodeVC];
    }else{
        [self.window setRootViewController:self.mainRootVC];
    }
    [self.window makeKeyAndVisible];
    // 友盟UMSocial
    [self LYUMSocialApplication:application didFinishLaunchingWithOptions:launchOptions];

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 禁止旋转屏幕
- (NSUInteger)application:(UIApplication *)application
supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - LYPasscodeViewControllerDelegate

- (void)passcodeViewController:(LYPasscodeViewController *)aViewController authenticatePasscode:(NSString *)aPasscode resultHandler:(void (^)(BOOL))aResultHandler{
    //
    if ([aPasscode isEqualToString:[LYPasscodeManager getOldPasscode]]) {
        aResultHandler(YES);
    } else {
        aResultHandler(NO);
    }
}

- (void)passcodeViewControllerDidFailAttempt:(LYPasscodeViewController *)aViewController{
    
    //验证失败
}

- (NSUInteger)passcodeViewControllerNumberOfFailedAttempts:(LYPasscodeViewController *)aViewController
{
    return 0;
}

- (NSDate *)passcodeViewControllerLockUntilDate:(LYPasscodeViewController *)aViewController
{
    return nil;
}

- (void)passcodeViewController:(LYPasscodeViewController *)aViewController didFinishWithPasscode:(NSString *)aPasscode{
    if (aViewController.type == LYPasscodeViewControllerCheckPasscodeType) {
        [self.window setRootViewController:self.mainRootVC];
    }

}

@end
