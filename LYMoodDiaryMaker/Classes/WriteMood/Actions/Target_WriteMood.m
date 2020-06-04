//
//  Target_WriteMood.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "Target_WriteMood.h"
#import "LYWriteMoodDiaryViewController.h"

@implementation Target_WriteMood

- (UIViewController *)Action_presentWriteMoodDiaryViewController:(NSDictionary *)params
{
    LYWriteMoodDiaryViewController *writeMDvc = [[LYWriteMoodDiaryViewController alloc] init];
    if (params[@"editMood"]) {
        writeMDvc.editMoodArray = params[@"editMood"];
    }
    return writeMDvc;
}

@end
