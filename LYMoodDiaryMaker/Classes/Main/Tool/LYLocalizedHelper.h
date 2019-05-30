//
//  LYLocalizedHelper.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/19.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LY_LocalizedString(key) [[LYLocalizedHelper standardHelper] stringWithKey:key]

NS_ASSUME_NONNULL_BEGIN

@interface LYLocalizedHelper : NSObject

+ (instancetype)standardHelper;

- (NSBundle *)bundle;

- (NSString *)currentLanguage;

- (void)setUserLanguage:(NSString *)language;

- (NSString *)stringWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
