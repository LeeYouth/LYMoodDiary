//
//  UIColor+LYMoodColor.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LYMoodColor)

/** 白色 */
+ (UIColor *)tableViewColor;

/** 疯狂 */
+ (UIColor *)madColor;
/** 开心 */
+ (UIColor *)happyColor;
/** 难过 */
+ (UIColor *)sadColor;
/** 喜欢 */
+ (UIColor *)inLoveColor;
/** 酷 */
+ (UIColor *)coolColor;
/** 大哭 */
+ (UIColor *)cryColor;
/** 睡着了 */
+ (UIColor *)sleepColor;
/** 饿死了 */
+ (UIColor *)hungryColor;

/** 按钮主题颜色 */
+ (UIColor *)themeButtonColor;

/** 无数据标题颜色 */
+ (UIColor *)emptyDataTitleColor;

/** 无数据副标题颜色 */
+ (UIColor *)emptyDataDetailTitleColor;


/** 列表视图头部标题颜色 */
+ (UIColor *)tableHeaderTitleColor;

/** 导航栏title颜色 */
+ (UIColor *)navTitleColor;

@end

NS_ASSUME_NONNULL_END
