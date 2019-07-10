//
//  LYServerConfig.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYServerConfig.h"

static NSString *LYConfigEnv;//（00: 测试环境 01: 正式环境）

@implementation LYServerConfig

+ (void)setLYConfigEnv:(LYServerEnvType)value
{
    if (value == LYServerEnvDevelop) {
        LYConfigEnv = @"00";
    }else if (value == LYServerEnvProduct){
        LYConfigEnv = @"01";
    }
}

+ (LYServerEnvType)LYConfigEnv
{
    if ([LYConfigEnv isEqualToString:@"00"]) {
        return LYServerEnvDevelop;
    }
    return LYServerEnvProduct;
}
@end
