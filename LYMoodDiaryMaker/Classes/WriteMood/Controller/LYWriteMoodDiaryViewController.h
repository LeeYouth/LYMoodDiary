//
//  LYWriteMoodDiaryViewController.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/13.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYBaseViewController.h"

@interface LYWriteMoodDiaryViewController : LYBaseTableViewController

/** 需要编辑的心情 */
@property(nonatomic, strong) NSMutableArray *editMoodArray;
/** 回调 */
@property(nonatomic, copy) LYViewDidSelected itemBlock;

@end

