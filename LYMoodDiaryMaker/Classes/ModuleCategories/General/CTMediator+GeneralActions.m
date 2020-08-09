//
//  CTMediator+GeneralActions.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator+GeneralActions.h"

NSString *const kLYTarget_General = @"General";
NSString *const kLYActionPushGeneralViewController = @"pushGeneralViewController";
NSString *const kLYActionPushGeneralLanguageController = @"pushGeneralLanguageController";
NSString *const kLYActionPushGenneralSearchViewController = @"pushGenneralSearchViewController";
NSString *const kLYActionPushCalendarMoodViewController = @"pushCalendarMoodViewController";
NSString *const kLYActionPresentExportMoodViewController = @"presentExportMoodViewController";
NSString *const kLYActionPushGeneralThemeSettingController = @"pushGeneralThemeSettingController";
NSString *const kLYActionPushPrivacyAgreementViewController = @"pushPrivacyAgreementViewController";
NSString *const kLYActionPushSettingViewController = @"pushSettingViewController";
NSString *const kLYActionPushGeneraPasscodeViewController = @"pushGeneraPasscodeViewController";

@implementation CTMediator (GeneralActions)

/// 通用
- (UIViewController *)CTMediator_GeneralViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushGeneralViewController
                        params:@{}
             shouldCacheTarget:NO
    ];
}

/// 多语言
- (UIViewController *)CTMediator_GeneralLanguageController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushGeneralLanguageController
                        params:@{}
             shouldCacheTarget:NO
    ];
}

/// 搜索
- (UIViewController *)CTMediator_GenneralSearchViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushGenneralSearchViewController
                        params:nil
             shouldCacheTarget:NO
    ];
}

/// 历史心情
- (UIViewController *)CTMediator_CalendarMoodViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushCalendarMoodViewController
                        params:nil
             shouldCacheTarget:NO
    ];
}

/// 导出
- (UIViewController *)CTMediator_ExportMoodViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPresentExportMoodViewController
                        params:nil
             shouldCacheTarget:NO
    ];
}

/// 夜间模式
- (UIViewController *)CTMediator_GeneralThemeSettingController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushGeneralThemeSettingController
                        params:nil
             shouldCacheTarget:NO
    ];
}

/// 隐私协议
- (UIViewController *)CTMediator_PrivacyAgreementViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushPrivacyAgreementViewController
                        params:nil
             shouldCacheTarget:NO
    ];
}

/// 设置
- (UIViewController *)CTMediator_SettingViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushSettingViewController
                        params:nil
             shouldCacheTarget:NO
    ];
}

/// 密码
- (UIViewController *)CTMediator_GeneraPasscodeViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushGeneraPasscodeViewController
                        params:nil
             shouldCacheTarget:NO
    ];
}

@end
