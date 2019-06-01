//
//  LYPasscodeManager.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYPasscodeManager.h"

@implementation LYPasscodeManager

/** 密码开关是否已打开 */
+ (BOOL)passcodeSwitchOn{
    return [kUserDefault boolForKey:kHASOPENPASSCODESWITCH];
}

/** touch id密码开关是否已打开 */
+ (BOOL)touchIDSwitchOn{
    return [kUserDefault boolForKey:kHASOPENPASSCODETOUCHID];
}

/** 是否已经设置过密码 */
+ (BOOL)hasSetPasscode{
    NSString *passcode = [kUserDefault valueForKey:kHASOPENPASSCODESTRING];
    if (passcode.length) {
        return YES;
    }
    return NO;
}

/** 保存密码 */
+ (BOOL)savePasscodeWithPasscode:(NSString *)passcode{
    [kUserDefault setObject:passcode forKey:kHASOPENPASSCODESTRING];
    return [kUserDefault synchronize];
}

/** 获取老密码 */
+ (NSString *)getOldPasscode{
    NSString *passcode = [kUserDefault valueForKey:kHASOPENPASSCODESTRING];
    return passcode;
}



@end
