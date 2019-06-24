//
//  LYGenneralSearchViewControllerModule.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/24.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGenneralSearchViewControllerModule.h"
#import "LYGenneralSearchViewController.h"

@interface LYGenneralSearchViewControllerModule()<BHModuleProtocol>

@end

@implementation LYGenneralSearchViewControllerModule

//+ (void)load
//{
//    // 加载模块
//    [BeeHive registerDynamicModule:[self class]];
//}
//
//- (id) init {
//    if ( self = [super init] ) {
//        LYLog(@"%@ init.", NSStringFromClass([self class]));
//    }
//    return self;
//}
//
//- (NSUInteger)moduleLevel
//{
//    return 0;
//}
//
//- (void)modSetUp:(BHContext *)context
//{
//    [[BeeHive shareInstance]  registerService:@protocol(LYGenneralSearchViewControllerProtocol) service:[LYGenneralSearchViewController class]];
//    [BHServiceManager sharedManager];
//    
//    LYLog(@"%@ setup.", NSStringFromClass([self class]));
//    
//}

@end
