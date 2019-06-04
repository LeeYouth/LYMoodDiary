//
//  LYMainRootViewController.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/31.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYBaseNavigationController.h"
#import "LYTabbarPlusButton.h"
#import "LYTabbarViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYMainRootViewController : LYBaseNavigationController

@property (nonatomic, strong) LYTabbarViewController *tabBarController;

@end

NS_ASSUME_NONNULL_END
