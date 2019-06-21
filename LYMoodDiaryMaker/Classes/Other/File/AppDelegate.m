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
#import "LYTouchIDDefultViewController.h"


@interface AppDelegate ()<LYPasscodeViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [BHContext shareInstance].application = application;
    [BHContext shareInstance].launchOptions = launchOptions;
//    [BHContext shareInstance].moduleConfigName = @"BeeHive.bundle/BeeHive";//可选，默认为BeeHive.bundle/BeeHive.plist
//    [BHContext shareInstance].serviceConfigName = @"BeeHive.bundle/LYService";
    
    [BeeHive shareInstance].enableException = YES;
    [[BeeHive shareInstance] setContext:[BHContext shareInstance]];
    [[BHTimeProfiler sharedTimeProfiler] recordEventTime:@"BeeHive::super start launch"];
    [super application:application didFinishLaunchingWithOptions:launchOptions];

    
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
    
    [LYRoutersRegister registerAllRouters];

    self.window = [[UIWindow alloc] init];
    
    
 
    //设置了密码
    if ([LYPasscodeManager passcodeSwitchOn] && [LYPasscodeManager hasSetPasscode]) {
        
        if ([LYPasscodeManager touchIDSwitchOn]) {
            //有限touch id
            LYTouchIDDefultViewController *cusVC = [[LYTouchIDDefultViewController alloc] init];
            [self.window setRootViewController:cusVC];
            
            [LYTouchIDManager initTouchIDWithMessage:@"" completion:^(BOOL prompted) {
                if (prompted) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.window setRootViewController:[[LYMainRootViewController alloc] init]];
                    });
                }else{
                    LYCustomPasscodeViewController *passcodeVC = [[LYCustomPasscodeViewController alloc] initWithNibName:nil bundle:nil];
                    passcodeVC.delegate = self;
                    passcodeVC.type = LYPasscodeViewControllerCheckPasscodeType;
                    passcodeVC.passcodeStyle = LYPasscodeInputViewNormalPasscodeStyle;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.window setRootViewController:passcodeVC];
                    });
                }
            }];
        }else{
            LYCustomPasscodeViewController *passcodeVC = [[LYCustomPasscodeViewController alloc] initWithNibName:nil bundle:nil];
            passcodeVC.delegate = self;
            passcodeVC.type = LYPasscodeViewControllerCheckPasscodeType;
            passcodeVC.passcodeStyle = LYPasscodeInputViewNormalPasscodeStyle;
            [self.window setRootViewController:passcodeVC];
        }
    }else{
        [self.window setRootViewController:[[LYMainRootViewController alloc] init]];
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
        [self.window setRootViewController:[[LYMainRootViewController alloc] init]];
    }

}

@end
