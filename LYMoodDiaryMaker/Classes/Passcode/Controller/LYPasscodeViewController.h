//
//  LYPasscodeViewController.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBaseViewController.h"
#import "LYPasscodeInputView.h"
#import "LYTouchIDSwitchView.h"
#import "LYTouchIDManager.h"


typedef enum : NSUInteger {
    LYPasscodeViewControllerNewPasscodeType,
    LYPasscodeViewControllerChangePasscodeType,
    LYPasscodeViewControllerCheckPasscodeType
} LYPasscodeViewControllerType;

@protocol LYPasscodeViewControllerDelegate;

@interface LYPasscodeViewController : LYBaseViewController <LYPasscodeInputViewDelegate, LYTouchIDSwitchViewDelegate>

@property (nonatomic, weak) id<LYPasscodeViewControllerDelegate> delegate;

@property (nonatomic) LYPasscodeViewControllerType              type;
@property (nonatomic) LYPasscodeInputViewPasscodeStyle          passcodeStyle;
@property (nonatomic) UIKeyboardType                            keyboardType;
@property (nonatomic, strong, readonly) LYPasscodeInputView     *passcodeInputView;
@property (nonatomic, strong) LYTouchIDManager                  *touchIDManager;

/**
 * Customize passcode input view
 * You may override to customize passcode input view appearance.
 */
- (void)customizePasscodeInputView:(LYPasscodeInputView *)aPasscodeInputView;

/**
 * Instantiate passcode input view.
 * You may override to use custom passcode input view.
 */
- (LYPasscodeInputView *)instantiatePasscodeInputView;

/**
 * Prompts Touch ID view to scan fingerprint.
 */
- (void)startTouchIDAuthenticationIfPossible;

/**
 * Prompts Touch ID view to scan fingerprint.
 * If Touch ID is disabled or unavailable, value of 'prompted' will be NO.
 */
- (void)startTouchIDAuthenticationIfPossible:(void(^)(BOOL prompted))aCompletionBlock;

@end

@protocol LYPasscodeViewControllerDelegate <NSObject>

/**
 * Tells the delegate that passcode is created or authenticated successfully.
 */
- (void)passcodeViewController:(LYPasscodeViewController *)aViewController didFinishWithPasscode:(NSString *)aPasscode;

@optional

/**
 * Tells the delegate that Touch ID error occured.
 */
- (void)passcodeViewControllerDidFailTouchIDKeychainOperation:(LYPasscodeViewController *)aViewController;

/**
 * Ask the delegate to verify that a passcode is correct. You must call the resultHandler with result.
 * You can check passcode asynchronously and show progress view (e.g. UIActivityIndicator) in the view controller if authentication takes too long.
 * You must call result handler in main thread.
 */
- (void)passcodeViewController:(LYPasscodeViewController *)aViewController authenticatePasscode:(NSString *)aPasscode resultHandler:(void(^)(BOOL succeed))aResultHandler;

/**
 * Tells the delegate that user entered incorrect passcode.
 * You should manage failed attempts yourself and it should be returned by -[LYPasscodeViewControllerDelegate passcodeViewControllerNumberOfFailedAttempts:] method.
 */
- (void)passcodeViewControllerDidFailAttempt:(LYPasscodeViewController *)aViewController;

/**
 * Ask the delegate that how many times incorrect passcode entered to display failed attempt count.
 */
- (NSUInteger)passcodeViewControllerNumberOfFailedAttempts:(LYPasscodeViewController *)aViewController;

/**
 * Ask the delegate that whether passcode view should lock or unlock.
 * If you return nil, passcode view will unlock otherwise it will lock until the date.
 */
- (NSDate *)passcodeViewControllerLockUntilDate:(LYPasscodeViewController *)aViewController;

@end

