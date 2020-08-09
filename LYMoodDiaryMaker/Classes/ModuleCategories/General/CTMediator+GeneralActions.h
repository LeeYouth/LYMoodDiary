//
//  CTMediator+GeneralActions.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (GeneralActions)

/// 通用
- (UIViewController *)CTMediator_GeneralViewController;
/// 多语言
- (UIViewController *)CTMediator_GeneralLanguageController;
/// 搜索
- (UIViewController *)CTMediator_GenneralSearchViewController;
/// 历史心情
- (UIViewController *)CTMediator_CalendarMoodViewController;
/// 导出
- (UIViewController *)CTMediator_ExportMoodViewController;
/// 夜间模式
- (UIViewController *)CTMediator_GeneralThemeSettingController;
/// 隐私协议
- (UIViewController *)CTMediator_PrivacyAgreementViewController;
/// 设置
- (UIViewController *)CTMediator_SettingViewController;
/// 密码
- (UIViewController *)CTMediator_GeneraPasscodeViewController;

@end

NS_ASSUME_NONNULL_END
