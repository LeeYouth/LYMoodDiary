//
//  Target_MoodDiary.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_MoodDiary : NSObject

- (UIViewController *)Action_pushMoodDiaryHomePageController:(NSDictionary *)params;

- (UIViewController *)Action_pushMoodDiaryPreviewViewController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
