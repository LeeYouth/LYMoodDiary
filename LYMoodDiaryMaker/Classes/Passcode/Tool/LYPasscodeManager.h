//
//  LYPasscodeManager.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYPasscodeManager : NSObject

/** 密码开关是否已打开 */
+ (BOOL)passcodeSwitchOn;

/** touch id密码开关是否已打开 */
+ (BOOL)touchIDSwitchOn;

/** 是否已经设置过密码 */
+ (BOOL)hasSetPasscode;

/** 保存密码 */
+ (BOOL)savePasscodeWithPasscode:(NSString *)passcode;

/** 获取老密码 */
+ (NSString *)getOldPasscode;


@end

NS_ASSUME_NONNULL_END
