//
//  CTMediator+MoodDiaryActions.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (MoodDiaryActions)

/// 主页
- (UIViewController *)CTMediator_MoodDiaryHomePageController;

/// 心情预览页面
- (UIViewController *)CTMediator_MoodDiaryPreviewViewControllerWithDate:(NSDate *)createDate;

@end

NS_ASSUME_NONNULL_END
