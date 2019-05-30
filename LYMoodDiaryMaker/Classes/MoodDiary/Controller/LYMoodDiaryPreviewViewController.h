//
//  LYMoodDiaryPreviewViewController.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//  心情预览界面

#import "LYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYMoodDiaryPreviewViewController : LYBaseTableViewController

/** 预览心情 */
@property(nonatomic, strong) LYMoodDiaryModel *previewModel;

@end

NS_ASSUME_NONNULL_END
