//
//  LYMoodDiaryDBManager.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryDBManager.h"

@implementation LYMoodDiaryDBManager

/** 保存一条心情日志 */
+ (BOOL)saveMoodDiaryWithModel:(LYMoodDiaryModel *)model{
    model.bg_tableName = kLYMOODTABLENAME;
    return [model bg_save];
}

/** 修改一条心情日志 */
+ (BOOL)updateMoodDiaryWithOrgModel:(LYMoodDiaryModel *)orgModel updateModel:(LYMoodDiaryModel *)updateModel{
    updateModel.bg_tableName  = kLYMOODTABLENAME;
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"enterDate"),bg_sqlValue(orgModel.enterDate)];
    return [updateModel bg_updateWhere:where];
}

/** 删除一条心情日志 */
+ (BOOL)deleteMoodDiaryWithModel:(LYMoodDiaryModel *)model{
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"enterDate"),bg_sqlValue(model.enterDate)];
    return [LYMoodDiaryModel bg_delete:kLYMOODTABLENAME where:where];
}

@end
