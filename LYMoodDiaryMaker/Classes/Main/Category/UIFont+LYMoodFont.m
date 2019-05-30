//
//  UIFont+LYMoodFont.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "UIFont+LYMoodFont.h"

@implementation UIFont (LYMoodFont)

+ (NSString *)realFontNameWithFontPath:(NSString *)fontPath{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Alibaba-PuHuiTi-Regular" ofType:@"otf"];
    NSURL *fontUrl = [NSURL fileURLWithPath:fontPath];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    return fontName;
}

+ (UIFont *)fontAliWithName:(AlibabaPuHuiTi)fontName size:(CGFloat)fontSize{
    switch (fontName) {
        case AlibabaPuHuiTiL:
        {
            return [UIFont fontWithName:@"AlibabaPuHuiTiL" size:fontSize];
        }
            break;
        case AlibabaPuHuiTiR:
        {
            return [UIFont fontWithName:@"AlibabaPuHuiTiR" size:fontSize];
        }
            break;
        case AlibabaPuHuiTiM:
        {
            return [UIFont fontWithName:@"AlibabaPuHuiTiM" size:fontSize];
        }
            break;
        case AlibabaPuHuiTiB:
        {
            return [UIFont fontWithName:@"AlibabaPuHuiTiB" size:fontSize];
        }
            break;
            
        default:
        {
            return [UIFont systemFontOfSize:fontSize];
        }
            break;
    }
}


+ (UIFont *)writeMoodFont{
    return [UIFont fontAliWithName:AlibabaPuHuiTiL size:20.f];
}

+ (UIFont *)moodFont{
    return [UIFont fontAliWithName:AlibabaPuHuiTiR size:16];
}
+ (UIFont *)moodTimeFont{
    return [UIFont fontAliWithName:AlibabaPuHuiTiR size:16.f];
}
/** 列表标题字号 */
+ (UIFont *)headerTitleFont{
    return [UIFont fontAliWithName:AlibabaPuHuiTiR size:28.f];
}
/** 列表副标题字号 */
+ (UIFont *)headerDetailFont{
    return [UIFont fontAliWithName:AlibabaPuHuiTiL size:16.f];
}

/** 关于我们 */
+ (UIFont *)aboutUsFont{
    return [UIFont fontAliWithName:AlibabaPuHuiTiL size:15.f];
}

@end
