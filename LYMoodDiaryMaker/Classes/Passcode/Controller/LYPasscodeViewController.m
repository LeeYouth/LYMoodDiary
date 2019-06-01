//
//  LYPasscodeViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYPasscodeViewController.h"
#import "LYShiftingView.h"
#import "LYViewShaker.h"
#import "LYPasscodeUtils.h"

typedef enum : NSUInteger {
    LYPasscodeViewControllerStateUnknown,
    LYPasscodeViewControllerStateCheckPassword,
    LYPasscodeViewControllerStateInputPassword,
    LYPasscodeViewControllerStateReinputPassword
} LYPasscodeViewControllerState;

#define kLYPasscodeOneMinuteInSeconds           (60)
#define kLYPasscodeDefaultKeyboardHeight        (216)

@interface LYPasscodeViewController ()

@property (nonatomic, strong) LYShiftingView                *shiftingView;

@property (nonatomic) LYPasscodeViewControllerState         currentState;
@property (nonatomic, strong) NSString                      *oldPasscode;
@property (nonatomic, strong) NSString                      *theNewPasscode;
@property (nonatomic, strong) NSTimer                       *lockStateUpdateTimer;
@property (nonatomic) CGFloat                               keyboardHeight;
@property (nonatomic, strong) LYViewShaker                  *viewShaker;

@property (nonatomic) BOOL                                  promptingTouchID;

@end

@implementation LYPasscodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // init state
        _type = LYPasscodeViewControllerNewPasscodeType;
        _currentState = LYPasscodeViewControllerStateInputPassword;
        
        // create shifting view
        self.shiftingView = [[LYShiftingView alloc] init];
        self.shiftingView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.shiftingView.currentView = [self instantiatePasscodeInputView];
        
        // keyboard notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveKeyboardWillShowHideNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveKeyboardWillShowHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveApplicationWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        self.keyboardHeight = kLYPasscodeDefaultKeyboardHeight;      // sometimes keyboard notification is not posted at all. so setting default value.
    }
    return self;
}

- (void)dealloc
{
    [self.lockStateUpdateTimer invalidate];
    self.lockStateUpdateTimer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setType:(LYPasscodeViewControllerType)type
{
    if (_type == type) {
        return;
    }
    
    _type = type;
    
    switch (type) {
        case LYPasscodeViewControllerNewPasscodeType:
            self.currentState = LYPasscodeViewControllerStateInputPassword;
            break;
        default:
            self.currentState = LYPasscodeViewControllerStateCheckPassword;
            break;
    }
}

- (LYPasscodeInputView *)passcodeInputView
{
    if (NO == [self.shiftingView.currentView isKindOfClass:[LYPasscodeInputView class]]) {
        return nil;
    }
    
    return (LYPasscodeInputView *)self.shiftingView.currentView;
}

- (LYPasscodeInputView *)instantiatePasscodeInputView
{
    LYPasscodeInputView *view = [[LYPasscodeInputView alloc] init];
    view.delegate = self;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return view;
}

- (void)customizePasscodeInputView:(LYPasscodeInputView *)aPasscodeInputView
{
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf);
    if (self.type == LYPasscodeViewControllerNewPasscodeType) {
        self.navBarView.leftBarItemImage  = [UIImage imageNamed:@"navBar_closeicon"];
    }else if (self.type == LYPasscodeViewControllerChangePasscodeType){
        self.navBarView.leftBarItemImage  = [UIImage imageNamed:@"navBar_closeicon"];
    }else{
        self.navBarView.leftBarItemImage = nil;
    }
    self.navBarView.btnBlock = ^(UIButton *sender) {
        if (sender.tag == 0) {
            [weakSelf backBarItemClick];
        }
    };
    
    [self.view setBackgroundColor:[UIColor tableViewColor]];
    
    [self updatePasscodeInputViewTitle:self.passcodeInputView];
    
    [self customizePasscodeInputView:self.passcodeInputView];
    
    [self.view addSubview:self.shiftingView];
    
    [self lockIfNeeded];
}

- (void)backBarItemClick{
    //返回
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.passcodeInputView.isEnabled) {
        [self startTouchIDAuthenticationIfPossible];
    }
    
    [self.passcodeInputView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    
    CGFloat topBarOffset = 0;
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        topBarOffset = [self.topLayoutGuide length];
    }
    
    frame.origin.y += topBarOffset;
    frame.size.height -= (topBarOffset + self.keyboardHeight);
    
    self.shiftingView.frame = frame;
}

#pragma mark - Public methods

- (void)setPasscodeStyle:(LYPasscodeInputViewPasscodeStyle)passcodeStyle
{
    self.passcodeInputView.passcodeStyle = passcodeStyle;
}

- (LYPasscodeInputViewPasscodeStyle)passcodeStyle
{
    return self.passcodeInputView.passcodeStyle;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    self.passcodeInputView.keyboardType = keyboardType;
}

- (UIKeyboardType)keyboardType
{
    return self.passcodeInputView.keyboardType;
}

- (void)showLockMessageWithLockUntilDate:(NSDate *)lockUntil
{
    NSTimeInterval timeInterval = [lockUntil timeIntervalSinceNow];
    NSUInteger minutes = ceilf(timeInterval / 60.0f);
    
    LYPasscodeInputView *inputView = self.passcodeInputView;
    inputView.enabled = NO;
    
    if (minutes == 1) {
        inputView.title = LY_LocalizedString(@"kLYInputViewOneMinutePasscode");
    } else {
        inputView.title = [NSString stringWithFormat:@"Try again in %@ minutes",@(minutes)];
    }
    
    NSUInteger numberOfFailedAttempts = [self.delegate passcodeViewControllerNumberOfFailedAttempts:self];
    
    [self showFailedAttemptsCount:numberOfFailedAttempts inputView:inputView];
    
    if (self.lockStateUpdateTimer == nil) {
        
        NSTimeInterval delay = timeInterval + kLYPasscodeOneMinuteInSeconds - (kLYPasscodeOneMinuteInSeconds * (NSTimeInterval)minutes);
        
        self.lockStateUpdateTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:delay]
                                                             interval:60.f
                                                               target:self
                                                             selector:@selector(lockStateUpdateTimerFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.lockStateUpdateTimer forMode:NSDefaultRunLoopMode];
    }
}

- (BOOL)lockIfNeeded
{
    if (self.currentState != LYPasscodeViewControllerStateCheckPassword) {
        return NO;
    }
    
    if (NO == [self.delegate respondsToSelector:@selector(passcodeViewControllerLockUntilDate:)]) {
        return NO;
    }
    
    NSDate *lockUntil = [self.delegate passcodeViewControllerLockUntilDate:self];
    if (lockUntil == nil || [lockUntil timeIntervalSinceNow] < 0) {
        return NO;
    }
    
    [self showLockMessageWithLockUntilDate:lockUntil];
    
    return YES;
}

- (void)updateLockMessageOrUnlockIfNeeded
{
    if (self.currentState != LYPasscodeViewControllerStateCheckPassword) {
        return;
    }
    
    if (NO == [self.delegate respondsToSelector:@selector(passcodeViewControllerLockUntilDate:)]) {
        return;
    }
    
    LYPasscodeInputView *inputView = self.passcodeInputView;
    
    NSDate *lockUntil = [self.delegate passcodeViewControllerLockUntilDate:self];
    
    if (lockUntil == nil || [lockUntil timeIntervalSinceNow] < 0) {
        
        // invalidate timer
        [self.lockStateUpdateTimer invalidate];
        self.lockStateUpdateTimer = nil;
        
        [self updatePasscodeInputViewTitle:inputView];
        
        inputView.enabled = YES;
        
    } else {
        [self showLockMessageWithLockUntilDate:lockUntil];
    }
}

- (void)lockStateUpdateTimerFired:(NSTimer *)timer
{
    [self updateLockMessageOrUnlockIfNeeded];
}

- (void)startTouchIDAuthenticationIfPossible
{
    [self startTouchIDAuthenticationIfPossible:nil];
}

- (void)startTouchIDAuthenticationIfPossible:(void (^)(BOOL))aCompletionBlock
{
    if (NO == [self canAuthenticateWithTouchID]) {
        if (aCompletionBlock) {
            aCompletionBlock(NO);
        }
        return;
    }
    
    self.promptingTouchID = YES;
    
    [self.touchIDManager loadPasscodeWithCompletionBlock:^(NSString *passcode) {
        
        self.promptingTouchID = NO;
        
        if (passcode) {
            
            self.passcodeInputView.passcode = passcode;
            
            [self passcodeInputViewDidFinish:self.passcodeInputView];
        }
        
        if (aCompletionBlock) {
            aCompletionBlock(YES);
        }
    }];
}

#pragma mark - Private methods

- (void)updatePasscodeInputViewTitle:(LYPasscodeInputView *)passcodeInputView
{
    switch (self.currentState) {
        case LYPasscodeViewControllerStateCheckPassword:
            if (self.type == LYPasscodeViewControllerChangePasscodeType) {
                passcodeInputView.title = LY_LocalizedString(@"kLYInputViewOldPasscode");
            } else {
                passcodeInputView.title = LY_LocalizedString(@"kLYInputViewInputPasscode");
            }
            break;
            
        case LYPasscodeViewControllerStateInputPassword:
            if (self.type == LYPasscodeViewControllerChangePasscodeType) {
                passcodeInputView.title = LY_LocalizedString(@"kLYInputViewInputNewPasscode");
            } else {
                passcodeInputView.title = LY_LocalizedString(@"kLYInputViewInputOnePasscode");
            }
            break;
            
        case LYPasscodeViewControllerStateReinputPassword:
            passcodeInputView.title = LY_LocalizedString(@"kLYInputViewReEnterPasscode");
            break;
            
        default:
            break;
    }
}

- (void)showFailedAttemptsCount:(NSUInteger)failCount inputView:(LYPasscodeInputView *)aInputView
{
    if (failCount == 0) {
        aInputView.errorMessage = LY_LocalizedString(@"kLYInputViewInvalidPasscode");
    } else if (failCount == 1) {
        aInputView.errorMessage = [@"1" stringByAppendingString:LY_LocalizedString(@"kLYInputViewAttemptPasscode")];
    } else {
        aInputView.errorMessage = [NSString stringWithFormat:@"%@%@",@(failCount),LY_LocalizedString(@"kLYInputViewAttemptPasscode")];
    }
}

- (void)showTouchIDSwitchView
{
    LYTouchIDSwitchView *view = [[LYTouchIDSwitchView alloc] init];
    view.delegate = self;
    view.touchIDSwitch.on = self.touchIDManager.isTouchIDEnabled;
    
    [self.shiftingView showView:view withDirection:LYShiftingDirectionForward];
}

- (BOOL)canAuthenticateWithTouchID
{
    if (NO == [LYTouchIDManager canUseTouchID]) {
        return NO;
    }
    
    if (self.type != LYPasscodeViewControllerCheckPasscodeType) {
        return NO;
    }
    
    if (nil == self.touchIDManager || NO == self.touchIDManager.isTouchIDEnabled) {
        return NO;
    }
    
    if (self.promptingTouchID) {
        return NO;
    }
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        return NO;
    }
    
    return YES;
}

#pragma mark - LYPasscodeInputViewDelegate

- (void)passcodeInputViewDidFinish:(LYPasscodeInputView *)aInputView
{
    NSString *passcode = aInputView.passcode;
    
    switch (self.currentState) {
        case LYPasscodeViewControllerStateCheckPassword:
        {
            NSAssert([self.delegate respondsToSelector:@selector(passcodeViewController:authenticatePasscode:resultHandler:)],
                     @"delegate must implement passcodeViewController:authenticatePasscode:resultHandler:");
            
            [self.delegate passcodeViewController:self authenticatePasscode:passcode resultHandler:^(BOOL succeed) {
                
                NSAssert([NSThread isMainThread], @"you must invoke result handler in main thread.");
                
                if (succeed) {
                    
                    if (self.type == LYPasscodeViewControllerChangePasscodeType) {
                        
                        self.oldPasscode = passcode;
                        self.currentState = LYPasscodeViewControllerStateInputPassword;
                        
                        LYPasscodeInputView *newPasscodeInputView = [self.passcodeInputView copy];
                        
                        [self customizePasscodeInputView:newPasscodeInputView];
                        
                        [self updatePasscodeInputViewTitle:newPasscodeInputView];
                        [self.shiftingView showView:newPasscodeInputView withDirection:LYShiftingDirectionForward];
                        
                        [self.passcodeInputView becomeFirstResponder];
                        
                    } else {
                        
                        [self.delegate passcodeViewController:self didFinishWithPasscode:passcode];
                        
                    }
                    
                } else {
                    
                    if ([self.delegate respondsToSelector:@selector(passcodeViewControllerDidFailAttempt:)]) {
                        [self.delegate passcodeViewControllerDidFailAttempt:self];
                    }
                    
                    NSUInteger failCount = 0;
                    
                    if ([self.delegate respondsToSelector:@selector(passcodeViewControllerNumberOfFailedAttempts:)]) {
                        failCount = [self.delegate passcodeViewControllerNumberOfFailedAttempts:self];
                    }
                    
                    [self showFailedAttemptsCount:failCount inputView:aInputView];
                    
                    // reset entered passcode
                    aInputView.passcode = nil;
                    
                    // shake
                    self.viewShaker = [[LYViewShaker alloc] initWithView:aInputView.passcodeField];
                    [self.viewShaker shakeWithDuration:0.5f completion:nil];
                    
                    // lock if needed
                    if ([self.delegate respondsToSelector:@selector(passcodeViewControllerLockUntilDate:)]) {
                        NSDate *lockUntilDate = [self.delegate passcodeViewControllerLockUntilDate:self];
                        if (lockUntilDate != nil) {
                            [self showLockMessageWithLockUntilDate:lockUntilDate];
                        }
                    }
                    
                }
            }];
            
            break;
        }
        case LYPasscodeViewControllerStateInputPassword:
        {
            if (self.type == LYPasscodeViewControllerChangePasscodeType && [self.oldPasscode isEqualToString:passcode]) {
                
                aInputView.passcode = nil;
                aInputView.message = LY_LocalizedString(@"kLYInputViewDontSamePasscode");
                
            } else {
                
                self.theNewPasscode = passcode;
                self.currentState = LYPasscodeViewControllerStateReinputPassword;
                
                LYPasscodeInputView *newPasscodeInputView = [self.passcodeInputView copy];
                
                [self customizePasscodeInputView:newPasscodeInputView];
                
                [self updatePasscodeInputViewTitle:newPasscodeInputView];
                [self.shiftingView showView:newPasscodeInputView withDirection:LYShiftingDirectionForward];
                
                [self.passcodeInputView becomeFirstResponder];
            }
            
            break;
        }
        case LYPasscodeViewControllerStateReinputPassword:
        {
            if ([passcode isEqualToString:self.theNewPasscode]) {
                
                if (self.touchIDManager && [LYTouchIDManager canUseTouchID]) {
                    [self showTouchIDSwitchView];
                } else {
                    [self.delegate passcodeViewController:self didFinishWithPasscode:passcode];
                }
                
            } else {
                
                self.currentState = LYPasscodeViewControllerStateInputPassword;
                
                LYPasscodeInputView *newPasscodeInputView = [self.passcodeInputView copy];
                
                [self customizePasscodeInputView:newPasscodeInputView];
                
                [self updatePasscodeInputViewTitle:newPasscodeInputView];
                
                newPasscodeInputView.message = LY_LocalizedString(@"kLYInputViewNotMatchPasscode");
                
                [self.shiftingView showView:newPasscodeInputView withDirection:LYShiftingDirectionBackward];
                
                [self.passcodeInputView becomeFirstResponder];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - LYTouchIDSwitchViewDelegate

- (void)touchIDSwitchViewDidPressDoneButton:(LYTouchIDSwitchView *)view
{
    BOOL enabled = view.touchIDSwitch.isOn;
    
    if (enabled) {
        
        [self.touchIDManager savePasscode:self.theNewPasscode completionBlock:^(BOOL success) {
            if (success) {
                [self.delegate passcodeViewController:self didFinishWithPasscode:self.theNewPasscode];
            } else {
                if ([self.delegate respondsToSelector:@selector(passcodeViewControllerDidFailTouchIDKeychainOperation:)]) {
                    [self.delegate passcodeViewControllerDidFailTouchIDKeychainOperation:self];
                }
            }
        }];
        
    } else {
        
        [self.touchIDManager deletePasscodeWithCompletionBlock:^(BOOL success) {
            if (success) {
                [self.delegate passcodeViewController:self didFinishWithPasscode:self.theNewPasscode];
            } else {
                if ([self.delegate respondsToSelector:@selector(passcodeViewControllerDidFailTouchIDKeychainOperation:)]) {
                    [self.delegate passcodeViewControllerDidFailTouchIDKeychainOperation:self];
                }
            }
        }];
    }
}

#pragma mark - Notifications

- (void)didReceiveKeyboardWillShowHideNotification:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        self.keyboardHeight = UIInterfaceOrientationIsPortrait(statusBarOrientation) ? CGRectGetHeight(keyboardRect) : CGRectGetWidth(keyboardRect);
    } else {
        self.keyboardHeight = CGRectGetHeight(keyboardRect);
    }
    
    [self.view setNeedsLayout];
}

- (void)didReceiveApplicationWillEnterForegroundNotification:(NSNotification *)notification
{
    [self startTouchIDAuthenticationIfPossible];
}

@end
