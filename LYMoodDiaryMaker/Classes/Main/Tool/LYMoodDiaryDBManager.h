//
//  LYMoodDiaryDBManager.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMoodDiaryDBManager : NSObject

/** 保存一条心情日志 */
+ (BOOL)saveMoodDiaryWithModel:(LYMoodDiaryModel *)model;

/** 修改一条心情日志 */
+ (BOOL)updateMoodDiaryWithOrgModel:(LYMoodDiaryModel *)orgModel updateModel:(LYMoodDiaryModel *)updateModel;

/** 删除一条心情日志 */
+ (BOOL)deleteMoodDiaryWithModel:(LYMoodDiaryModel *)model;

@end

NS_ASSUME_NONNULL_END
