//
//  Target_General.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/3.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_General : NSObject

/// 通用界面
- (UIViewController *)Action_pushGeneralViewController:(NSDictionary *)params;
/// 多语言
- (UIViewController *)Action_pushGeneralLanguageController:(NSDictionary *)params;
/// 搜索
- (UIViewController *)Action_pushGenneralSearchViewController:(NSDictionary *)params;
/// 历史心情
- (UIViewController *)Action_pushCalendarMoodViewController:(NSDictionary *)params;
/// 导出
- (UIViewController *)Action_presentExportMoodViewController:(NSDictionary *)params;
/// 新手指南
- (UIViewController *)Action_pushNoviceManualViewController:(NSDictionary *)params;
/// 隐私协议
- (UIViewController *)Action_pushPrivacyAgreementViewController:(NSDictionary *)params;
/// 设置
- (UIViewController *)Action_pushSettingViewController:(NSDictionary *)params;
/// 密码
- (UIViewController *)Action_pushGeneraPasscodeViewController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
