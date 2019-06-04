//
//  NSBundle+LYUtils.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (LYUtils)

+ (BOOL)isChineseLanguage;

+ (NSString *)currentLanguage;

+ (NSArray *)allLanguages;

@end

NS_ASSUME_NONNULL_END
