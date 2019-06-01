//
//  LYPasscodeLockScreenManager.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYPasscodeViewController.h"
#import "LYPasscodeDummyViewController.h"
@class LYPasscodeLockScreenManager;

@protocol LYPasscodeLockScreenManagerDelegate <NSObject>

/**
 * Ask the delegate a view controller that should be displayed as lock screen.
 */
- (UIViewController *)lockScreenManagerPasscodeViewController:(LYPasscodeLockScreenManager *)aManager;

@optional
/**
 * Ask the delegate that lock screen should be displayed or not.
 * If you prevent displaying lock screen, return NO.
 * If delegate does not implement this method, the lock screen will be shown everytime when application did enter background.
 */
- (BOOL)lockScreenManagerShouldShowLockScreen:(LYPasscodeLockScreenManager *)aManager;

/**
 * Ask the delegate for the view that will be used as snapshot.
 */
- (UIView *)lockScreenManagerBlindView:(LYPasscodeLockScreenManager *)aManager;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LYPasscodeLockScreenManager : NSObject <LYPasscodeLockScreenManagerDelegate>

@property (weak, nonatomic) id<LYPasscodeLockScreenManagerDelegate> delegate;

/**
 * Shared(singleton) instance.
 */
+ (LYPasscodeLockScreenManager *)sharedManager;

/**
 * Shows lock screen. You should call this method at applicationDidEnterBackground: in app delegate.
 */
- (void)showLockScreen:(BOOL)animated;

@end




NS_ASSUME_NONNULL_END
