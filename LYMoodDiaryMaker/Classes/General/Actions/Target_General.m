//
//  Target_General.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/3.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "Target_General.h"
#import "LYGeneralLanguageController.h"
#import "LYGenneralSearchViewController.h"
#import "LYCalendarMoodViewController.h"
#import "LYExportMoodViewController.h"
#import "LYNoviceManualViewController.h"
#import "LYPrivacyAgreementViewController.h"
#import "LYSettingViewController.h"
#import "LYGeneraPasscodeViewController.h"

@implementation Target_General

- (UIViewController *)Action_pushGeneralLanguageController:(NSDictionary *)params
{
    return [[LYGeneralLanguageController alloc] init];
}

- (UIViewController *)Action_pushGenneralSearchViewController:(NSDictionary *)params
{
    return [[LYGenneralSearchViewController alloc] init];
}

- (UIViewController *)Action_pushCalendarMoodViewController:(NSDictionary *)params
{
    return [[LYCalendarMoodViewController alloc] init];
}

- (UIViewController *)Action_presentExportMoodViewController:(NSDictionary *)params
{
    return [[LYExportMoodViewController alloc] init];
}

- (UIViewController *)Action_pushNoviceManualViewController:(NSDictionary *)params
{
    return [[LYNoviceManualViewController alloc] init];
}

- (UIViewController *)Action_pushPrivacyAgreementViewController:(NSDictionary *)params
{
    return [[LYPrivacyAgreementViewController alloc] init];
}

- (UIViewController *)Action_pushSettingViewController:(NSDictionary *)params
{
    return [[LYSettingViewController alloc] init];
}

- (UIViewController *)Action_pushGeneraPasscodeViewController:(NSDictionary *)params
{
    return [[LYGeneraPasscodeViewController alloc] init];
}
@end
