//
//  LYCSVWriter.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/20.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCSVWriter : NSObject

/** 导出文件 */
+ (NSString *)exportCSVWithMoods:(NSArray *)moods;

@end

NS_ASSUME_NONNULL_END
