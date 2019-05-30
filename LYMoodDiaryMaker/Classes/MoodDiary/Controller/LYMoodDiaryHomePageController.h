//
//  LYMoodDiaryHomePageController.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/24.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYMoodDiaryHomePageControllerBlock)(LYMoodDiaryModel *model);

@interface LYMoodDiaryHomePageController : LYBaseTableViewController

@property(nonatomic, assign) BOOL yesterday;
@property(nonatomic, copy) LYViewDidSelected itemClick;

/** 刷新下数据 */
- (void)reloadTableData;

@end

NS_ASSUME_NONNULL_END
