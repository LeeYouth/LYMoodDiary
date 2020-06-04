//
//  Target_MoodDiary.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "Target_MoodDiary.h"
#import "LYMoodDiaryHomePageController.h"
#import "LYMoodDiaryPreviewViewController.h"

@implementation Target_MoodDiary

- (UIViewController *)Action_pushMoodDiaryHomePageController:(NSDictionary *)params
{
    return [[LYMoodDiaryHomePageController alloc] init];
}

- (UIViewController *)Action_pushMoodDiaryPreviewViewController:(NSDictionary *)params
{
    LYMoodDiaryPreviewViewController *vc = [[LYMoodDiaryPreviewViewController alloc] init];
    vc.creatDate = params[@"date"];
    return vc;
}
@end
