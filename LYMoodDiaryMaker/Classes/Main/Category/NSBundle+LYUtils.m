//
//  NSBundle+LYUtils.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "NSBundle+LYUtils.h"
#import "LYLocalizedConfig.h"
#import <objc/runtime.h>

@interface LYBundle : NSBundle

@end

@implementation NSBundle (LYUtils)

+ (BOOL)isChineseLanguage
{
    NSString *currentLanguage = [self currentLanguage];
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)currentLanguage
{
    return [LYLocalizedConfig userLanguage] ? : [NSLocale preferredLanguages].firstObject;
}

+ (NSArray *)allLanguages{

    return @[@"zh-Hans",@"en",@"ja",@"fr",@"ko"];
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //动态继承、交换，方法类似KVO，通过修改[NSBundle mainBundle]对象的isa指针，使其指向它的子类DABundle，这样便可以调用子类的方法；其实这里也可以使用method_swizzling来交换mainBundle的实现，来动态判断，可以同样实现。
        object_setClass([NSBundle mainBundle], [LYBundle class]);
    });
}

@end

@implementation LYBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    if ([LYBundle uw_mainBundle]) {
        return [[LYBundle uw_mainBundle] localizedStringForKey:key value:value table:tableName];
    } else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

+ (NSBundle *)uw_mainBundle
{
    if ([NSBundle currentLanguage].length) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSBundle currentLanguage] ofType:@"lproj"];
        if (path.length) {
            return [NSBundle bundleWithPath:path];
        }
    }
    return nil;
}

@end
