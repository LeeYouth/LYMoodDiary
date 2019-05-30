//
//  LYExportMoodHeaderView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYExportMoodHeaderView : UIView

/** 开始时间 */
@property (nonatomic, strong) NSDate *beginDate;
/** 结束时间 */
@property (nonatomic, strong) NSDate *endDate;

+ (CGFloat)getViewHeight;

@end

NS_ASSUME_NONNULL_END
