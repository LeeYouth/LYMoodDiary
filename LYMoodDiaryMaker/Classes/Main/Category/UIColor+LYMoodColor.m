//
//  UIColor+LYMoodColor.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "UIColor+LYMoodColor.h"

@implementation UIColor (LYMoodColor)

+ (UIColor *)tableViewColor{
    return [UIColor whiteColor];
}

+ (UIColor *)madColor{
    return LYRGBACOLOR(253, 104, 133, 1);
}

+ (UIColor *)happyColor{
    return LYRGBACOLOR(48, 169, 222, 1);
}

+ (UIColor *)sadColor{
    return LYRGBACOLOR(86, 98, 112, 1);
}

+ (UIColor *)inLoveColor{
    return LYRGBACOLOR(241,107,111, 1);
}

+ (UIColor *)coolColor{
    return LYRGBACOLOR(157,200,200, 1);
}

+ (UIColor *)cryColor{
    return LYRGBACOLOR(215,255,241, 1);
}

+ (UIColor *)sleepColor{
    return LYRGBACOLOR(165,147,224, 1);
}

+ (UIColor *)hungryColor{
    return LYRGBACOLOR(117,79,68, 1);
}

+ (UIColor *)themeButtonColor{
    return LYColor(@"#EF664B");
}

+ (UIColor *)emptyDataTitleColor{
    return LYRGBACOLOR(146, 146, 146,1);
}

+ (UIColor *)emptyDataDetailTitleColor{
    return LYRGBACOLOR(153, 153, 153,1);
}

+ (UIColor *)tableHeaderTitleColor{
    return LYColor(LYBlackColorHex);
}

+ (UIColor *)navTitleColor{
    return LYColor(LYBlackColorHex);
}
@end
