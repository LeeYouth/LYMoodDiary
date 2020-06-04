//
//  CTMediator+CTMediatorGeneralActions.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/3.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (CTMediatorGeneralActions)

/// 多语言
- (UIViewController *)CTMediator_GeneralLanguageController;
/// 搜索
- (UIViewController *)CTMediator_GenneralSearchViewController;
/// 历史心情
- (UIViewController *)CTMediator_CalendarMoodViewController;
/// 导出
- (UIViewController *)CTMediator_ExportMoodViewController;
/// 新手指南
- (UIViewController *)CTMediator_NoviceManualViewController;
/// 隐私协议
- (UIViewController *)CTMediator_PrivacyAgreementViewController;
/// 设置
- (UIViewController *)CTMediator_SettingViewController;
/// 密码
- (UIViewController *)CTMediator_GeneraPasscodeViewController;

@end

NS_ASSUME_NONNULL_END
