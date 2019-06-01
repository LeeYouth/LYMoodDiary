//
//  LYPasscodeField.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYPasscodeFieldDelegate;
@protocol LYPasscodeFieldImageSource;

@interface LYPasscodeField : UIControl <UIKeyInput>

// delegate
@property (nonatomic, weak) id<LYPasscodeFieldDelegate> delegate;
@property (nonatomic, weak) id<LYPasscodeFieldImageSource> imageSource;

// passcode
@property (nonatomic, strong) NSString      *passcode;

// configurations
@property (nonatomic) NSUInteger            maximumLength;
@property (nonatomic) CGSize                dotSize;
@property (nonatomic) CGFloat               lineHeight;
@property (nonatomic) CGFloat               dotSpacing;
@property (nonatomic, strong) UIColor       *dotColor;

@property (nonatomic) UIKeyboardType        keyboardType;

@end


@protocol LYPasscodeFieldDelegate <NSObject>

@optional
/**
 * Ask the delegate that whether passcode field accepts text.
 * If you want to accept entering text, return YES.
 */
- (BOOL)passcodeField:(LYPasscodeField *)aPasscodeField shouldInsertText:(NSString *)aText;

/**
 * Ask the delegate that whether passcode can be deleted.
 * If you want to accept deleting passcode, return YES.
 */
- (BOOL)passcodeFieldShouldDeleteBackward:(LYPasscodeField *)aPasscodeField;

@end


@protocol LYPasscodeFieldImageSource <NSObject>

@optional

/**
 * Ask the image source for a image to display passcode digit at index.
 * If you don't implement this, default shape (line for blank digit and circule for filled digit) will be displayed.
 */
- (UIImage *)passcodeField:(LYPasscodeField *)aPasscodeField dotImageAtIndex:(NSInteger)aIndex filled:(BOOL)aFilled;

@end

