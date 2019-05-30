//
//  UIFont+LYMoodFont.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AlibabaPuHuiTiL,
    AlibabaPuHuiTiR,
    AlibabaPuHuiTiM,
    AlibabaPuHuiTiB,
} AlibabaPuHuiTi;

@interface UIFont (LYMoodFont)

/** 获取导入的字体的真正的name */
+ (NSString *)realFontNameWithFontPath:(NSString *)fontPath;


/**
 阿里字体

 @param fontName 字体类型
 @param fontSize 字重
 */
+ (UIFont *)fontAliWithName:(AlibabaPuHuiTi)fontName size:(CGFloat)fontSize;


/** 写心情日记的字体 */
+ (UIFont *)writeMoodFont;

/** 列表心情字体大小 */
+ (UIFont *)moodFont;
/** 列表心情时间字体大小 */
+ (UIFont *)moodTimeFont;

/** 列表标题字号 */
+ (UIFont *)headerTitleFont;
/** 列表副标题字号 */
+ (UIFont *)headerDetailFont;

/** 关于我们 */
+ (UIFont *)aboutUsFont;

@end

NS_ASSUME_NONNULL_END
