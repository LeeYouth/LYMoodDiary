//
//  CTMediator+CTMediatorGeneralActions.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/3.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator+CTMediatorGeneralActions.h"

NSString *const kLYTarget_General = @"General";
NSString *const kLYActionPushGeneralLanguageController = @"pushGeneralLanguageController";
NSString *const kLYActionPushGenneralSearchViewController = @"pushGenneralSearchViewController";
NSString *const kLYActionPushCalendarMoodViewController = @"pushCalendarMoodViewController";
NSString *const kLYActionPresentExportMoodViewController = @"presentExportMoodViewController";
NSString *const kLYActionPushNoviceManualViewController = @"pushNoviceManualViewController";
NSString *const kLYActionPushPrivacyAgreementViewController = @"pushPrivacyAgreementViewController";
NSString *const kLYActionPushSettingViewController = @"pushSettingViewController";
NSString *const kLYActionPushGeneraPasscodeViewController = @"pushGeneraPasscodeViewController";

@implementation CTMediator (CTMediatorGeneralActions)
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

/// 新手指南
- (UIViewController *)CTMediator_NoviceManualViewController
{
    return [self performTarget:kLYTarget_General
                        action:kLYActionPushNoviceManualViewController
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
