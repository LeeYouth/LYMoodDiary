//
//  LYLocalizedConfig.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LY_LocalizedString(key) NSLocalizedString(key, nil)

NS_ASSUME_NONNULL_BEGIN

@interface LYLocalizedConfig : NSObject
/**
 用户自定义使用的语言，当传nil时，等同于resetSystemLanguage
 */
@property (class, nonatomic, strong, nullable) NSString *userLanguage;
/**
 重置系统语言
 */
+ (void)resetSystemLanguage;


@end

NS_ASSUME_NONNULL_END
