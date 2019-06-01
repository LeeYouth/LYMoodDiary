//
//  LYPasscodeInputView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPasscodeField.h"

typedef enum : NSUInteger {
    LYPasscodeInputViewNumericPasscodeStyle,
    LYPasscodeInputViewNormalPasscodeStyle,
} LYPasscodeInputViewPasscodeStyle;


@protocol LYPasscodeInputViewDelegate;


@interface LYPasscodeInputView : UIView <UITextFieldDelegate, LYPasscodeFieldDelegate, NSCopying>

@property (nonatomic, weak) id<LYPasscodeInputViewDelegate> delegate;

@property (nonatomic) LYPasscodeInputViewPasscodeStyle  passcodeStyle;
@property (nonatomic) UIKeyboardType                    keyboardType;
@property (nonatomic) NSUInteger                        maximumLength;

@property (nonatomic, strong) NSString                  *title;
@property (nonatomic, strong) NSString                  *message;
@property (nonatomic, strong) NSString                  *errorMessage;
@property (nonatomic, getter = isEnabled) BOOL          enabled;
@property (nonatomic, strong) NSString                  *passcode;

@property (nonatomic, strong, readonly) UIControl       *passcodeField;

@property (nonatomic, strong) UIFont                    *titleFont;
@property (nonatomic, strong) UIColor                   *titleColor;
@property (nonatomic, strong) UIFont                    *messageFont;
@property (nonatomic, strong) UIColor                   *messageColor;
@property (nonatomic, strong) UIFont                    *errorMessageFont;
@property (nonatomic, strong) UIColor                   *errorMessageColor;

// You can override these methods to customize message label appearance.
+ (void)configureTitleLabel:(UILabel *)aLabel;
+ (void)configureMessageLabel:(UILabel *)aLabel;
+ (void)configureErrorMessageLabel:(UILabel *)aLabel;

@end


@protocol LYPasscodeInputViewDelegate <NSObject>

/**
 * Tells the delegate that maximum length of passcode is entered or user tapped Done button in the keyboard (in case of LYPasscodeInputViewNormalPasscodeStyle).
 */
- (void)passcodeInputViewDidFinish:(LYPasscodeInputView *)aInputView;

@end
