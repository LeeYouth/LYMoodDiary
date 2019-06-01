//
//  LYPasscodeLockScreenManager.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYPasscodeLockScreenManager.h"
#import "LYPasscodeViewController.h"

static LYPasscodeLockScreenManager *_sharedManager;

@interface LYPasscodeLockScreenManager ()

@property (strong, nonatomic) UIWindow  *mainWindow;
@property (strong, nonatomic) UIWindow  *lockScreenWindow;
@property (strong, nonatomic) UIView    *blindView;

@end

@implementation LYPasscodeLockScreenManager

+ (LYPasscodeLockScreenManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[LYPasscodeLockScreenManager alloc] init];
    });
    return _sharedManager;
}

- (void)showLockScreen:(BOOL)animated
{
    if (self.lockScreenWindow && self.lockScreenWindow.rootViewController) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(lockScreenManagerShouldShowLockScreen:)]) {
        if (NO == [self.delegate lockScreenManagerShouldShowLockScreen:self]) {
            return;
        }
    }
    
    // get the main window
    self.mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    // dismiss keyboard before showing lock screen
    [self.mainWindow.rootViewController.view endEditing:YES];
    
    // add blind view
    UIView *blindView;
    
    if ([self.delegate respondsToSelector:@selector(lockScreenManagerBlindView:)]) {
        blindView = [self.delegate lockScreenManagerBlindView:self];
    }
    
    if (nil == blindView) {
        blindView = [[UIView alloc] init];
        blindView.backgroundColor = [UIColor whiteColor];
    }
    
    blindView.frame = self.mainWindow.bounds;
    blindView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.mainWindow addSubview:blindView];
    
    self.blindView = blindView;
    
    // set dummy view controller as root view controller
    LYPasscodeDummyViewController *dummyViewController = [[LYPasscodeDummyViewController alloc] init];
    
    UIWindow *lockScreenWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lockScreenWindow.windowLevel = self.mainWindow.windowLevel + 1;
    lockScreenWindow.rootViewController = dummyViewController;
    lockScreenWindow.backgroundColor = [UIColor clearColor];
    [lockScreenWindow makeKeyAndVisible];
    
    // present lock screen
    UIViewController *lockScreenViewController = [self.delegate lockScreenManagerPasscodeViewController:self];
    
    if (animated) {
        blindView.hidden = YES;
    }
    
    [lockScreenWindow.rootViewController presentViewController:lockScreenViewController animated:animated completion:^{
        blindView.hidden = NO;
    }];
    
    self.lockScreenWindow = lockScreenWindow;
    
    [lockScreenViewController.view.superview bringSubviewToFront:lockScreenViewController.view];
    
    dummyViewController.delegate = self;
}

- (void)dummyViewControllerWillAppear:(LYPasscodeDummyViewController *)aViewController
{
    // remove blind view
    [self.blindView removeFromSuperview];
    self.blindView = nil;
}

- (void)dummyViewControllerDidAppear:(LYPasscodeDummyViewController *)aViewController
{
    if ([UIView instancesRespondToSelector:@selector(tintColor)]) {
        self.lockScreenWindow = nil;
    } else {
        [self performSelector:@selector(setLockScreenWindow:) withObject:nil afterDelay:0.1f];      // workaround for wired dealloc on iOS 6
    }
    
    [self.mainWindow makeKeyAndVisible];
    self.mainWindow = nil;
}

@end
