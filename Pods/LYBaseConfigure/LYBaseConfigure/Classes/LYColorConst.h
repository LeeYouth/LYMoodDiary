//
//  LYColorConst.h
//  LYMoodDiaryMaker
//
//  Created by liyong yuan on 2019/7/30.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#ifndef LYColorConst_h
#define LYColorConst_h

/// RGB颜色
#define LYRGBAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define LYRGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

#define LYHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define LYHexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

/// 常用颜色
#define red_color       [UIColor redColor]
#define black_color     [UIColor blackColor]
#define blue_color      [UIColor blueColor]
#define brown_color     [UIColor brownColor]
#define clear_color     [UIColor clearColor]
#define darkGray_color  [UIColor darkGrayColor]
#define darkText_color  [UIColor darkTextColor]
#define white_color     [UIColor whiteColor]
#define yellow_color    [UIColor yellowColor]
#define orange_color    [UIColor orangeColor]
#define purple_color    [UIColor purpleColor]
#define lightText_color [UIColor lightTextColor]
#define lightGray_color [UIColor lightGrayColor]
#define green_color     [UIColor greenColor]
#define gray_color      [UIColor grayColor]
#define magenta_color   [UIColor magentaColor]

/// APP规范
#define bgColor white_color
#define sepLineColor LYHexRGB(0xEEEEEE)
#define themeColor  LYHexRGB(0xFE4365)
#define tableViewBgColor      white_color

#define madColor      LYRGBAlpha(253, 104, 133, 1)
#define happyColor    LYRGBAlpha(48, 169, 222, 1)
#define sadColor      LYRGBAlpha(86, 98, 112, 1)
#define inLoveColor   LYRGBAlpha(241,107,111, 1)
#define coolColor     LYRGBAlpha(157,200,200, 1)
#define cryColor      LYRGBAlpha(215,255,241, 1)
#define sleepColor    LYRGBAlpha(165,147,224, 1)
#define hungryColor   LYRGBAlpha(117,79,68, 1)
#define themeButtonColor   LYHexRGB(0xEF664B)
#define emptyDataTitleColor   LYRGBAlpha(146, 146, 146,1)
#define emptyDataDetailTitleColor   LYRGBAlpha(153, 153, 153,1)
#define tableHeaderTitleColor   black_color
#define navTitleColor   black_color

#endif /* LYColorConst_h */
