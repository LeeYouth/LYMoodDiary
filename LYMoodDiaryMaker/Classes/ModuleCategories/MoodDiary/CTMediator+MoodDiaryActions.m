//
//  CTMediator+MoodDiaryActions.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator+MoodDiaryActions.h"

NSString *const kLYTarget_MoodDiary = @"MoodDiary";
NSString *const kLYActionPushMoodDiaryHomePageController = @"pushMoodDiaryHomePageController";
NSString *const kLYActionPushMoodDiaryPreviewViewController = @"pushMoodDiaryPreviewViewController";

@implementation CTMediator (MoodDiaryActions)

- (UIViewController *)CTMediator_MoodDiaryHomePageController
{
    return [self performTarget:kLYTarget_MoodDiary
                        action:kLYActionPushMoodDiaryHomePageController
                        params:@{}
             shouldCacheTarget:NO
    ];
}

- (UIViewController *)CTMediator_MoodDiaryPreviewViewControllerWithDate:(NSDate *)createDate
{
    return [self performTarget:kLYTarget_MoodDiary
                        action:kLYActionPushMoodDiaryPreviewViewController
                        params:@{@"date":createDate}
             shouldCacheTarget:NO
    ];
}


@end
