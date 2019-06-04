//
//  LYLocalizedConfig.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYLocalizedConfig.h"

static NSString *const LYUserLanguageKey = @"LYUserLanguageKey";

@implementation LYLocalizedConfig

+ (void)setUserLanguage:(NSString *)userLanguage
{    
    //跟随手机系统
    if (!userLanguage.length) {
        [self resetSystemLanguage];
        return;
    }
    //用户自定义
    [kUserDefault setValue:userLanguage forKey:LYUserLanguageKey];
    [kUserDefault setValue:@[userLanguage] forKey:@"AppleLanguages"];
    [kUserDefault synchronize];
}

+ (NSString *)userLanguage
{
    return [kUserDefault valueForKey:LYUserLanguageKey];
}

/**
 重置系统语言
 */
+ (void)resetSystemLanguage
{
    [kUserDefault removeObjectForKey:LYUserLanguageKey];
    [kUserDefault setValue:nil forKey:@"AppleLanguages"];
    [kUserDefault synchronize];
}

@end

