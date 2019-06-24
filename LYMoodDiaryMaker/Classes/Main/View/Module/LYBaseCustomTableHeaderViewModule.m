//
//  LYBaseCustomTableHeaderViewModule.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/21.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYBaseCustomTableHeaderViewModule.h"
#import "LYBaseCustomTableHeaderView.h"

@interface LYBaseCustomTableHeaderViewModule()<BHModuleProtocol>

@end

@implementation LYBaseCustomTableHeaderViewModule

+ (void)load
{
    // 加载模块
    [BeeHive registerDynamicModule:[self class]];
}

- (id) init {
    if ( self = [super init] ) {
        LYLog(@"%@ init.", NSStringFromClass([self class]));
    }
    return self;
}

- (NSUInteger)moduleLevel
{
    return 0;
}

- (void)modSetUp:(BHContext *)context
{
    [[BeeHive shareInstance]  registerService:@protocol(LYBaseCustomTableHeaderViewProtocol) service:[LYBaseCustomTableHeaderView class]];
    [BHServiceManager sharedManager];
    
    LYLog(@"%@ setup.", NSStringFromClass([self class]));

}

@end
