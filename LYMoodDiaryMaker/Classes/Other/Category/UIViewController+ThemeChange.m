//
//  UIViewController+ThemeChange.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/8.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "UIViewController+ThemeChange.h"

@implementation UIViewController (ThemeChange)

+ (void)load{
    // 适配ios  13  这里做方法交换
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 系统模态方法，  做方法交换
        Method systemPresent = class_getInstanceMethod(self,@selector(traitCollectionDidChange:));
        Method custom_Method = class_getInstanceMethod(self,@selector(ly_traitCollectionDidChange:));
        method_exchangeImplementations(systemPresent, custom_Method);
    });

}
- (void)ly_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
//    NSString *type = [kUserDefault valueForKey:@"LYDarkModel"];
//    if (type.length == 0 || (type.length && [type isEqualToString:@"flowSystem"])) {
//
//    }
    if (@available(iOS 13.0, *)) {
            if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
                if (![self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]) {
                    [self setThemeLight];
                }
            }else {
                if (![self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
                    [self setThemeDark];
                }
            }
        }else{
            if (![self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]) {
                [self setThemeLight];
            }
        }
    
    [self ly_traitCollectionDidChange:previousTraitCollection];
}

- (void)setThemeDark
{
    [self.dk_manager nightFalling];
}

- (void)setThemeLight
{
    [self.dk_manager dawnComing];
}

@end
