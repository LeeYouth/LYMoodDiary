//
//  LYWriteMoodDiaryViewProtocol.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/21.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//  跳转写心情或者编辑心情

#import <Foundation/Foundation.h>

@protocol LYWriteMoodDiaryViewProtocol <NSObject, BHServiceProtocol>

/** 需要编辑的心情 */
@property(nonatomic, strong) NSMutableArray *editMoodArray;
/** 回调 */
@property(nonatomic, copy) LYViewDidSelected itemBlock;

@end
