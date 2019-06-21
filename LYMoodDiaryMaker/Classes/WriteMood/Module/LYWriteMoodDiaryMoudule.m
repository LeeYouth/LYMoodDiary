//
//  LYWriteMoodDiaryMoudule.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/21.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYWriteMoodDiaryMoudule.h"
#import "LYWriteMoodDiaryViewController.h"

@interface LYWriteMoodDiaryMoudule()<BHModuleProtocol>

@end

@implementation LYWriteMoodDiaryMoudule

+ (void)load
{
    // 加载模块
    [BeeHive registerDynamicModule:[self class]];
}

- (id) init {
    if ( self = [super init] ) {
        LYLog(@"HBHPageModule init.");
    }
    return self;
}

- (NSUInteger)moduleLevel
{
    return 0;
}

- (void)modSetUp:(BHContext *)context
{
    [[BeeHive shareInstance]  registerService:@protocol(LYWriteMoodDiaryViewProtocol) service:[LYWriteMoodDiaryViewController class]];
    [BHServiceManager sharedManager];

    LYLog(@"LYWriteMoodDiaryMoudule setup");
    
}


@end
