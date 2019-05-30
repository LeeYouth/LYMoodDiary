//
//  LYCalendarPickerMenu.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/16.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//  日历选择

#import <UIKit/UIKit.h>
@class LYCalendarPickerMenu;

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYCalendarPickerMenuDidSelect)(NSDate *didSelectDate);

@protocol LYCalendarPickerMenuDelegate <NSObject>

@optional
- (void)lyCalendarMenuBeganDismiss;
- (void)lyCalendarMenuDidDismiss;
- (void)lyCalendarMenuBeganShow;
- (void)lyCalendarMenuDidShow;

@end

@interface LYCalendarPickerMenu : UIView

- (instancetype)initRelyOnView:(UIView *)view;

/**
 代理
 */
@property (nonatomic, weak) id <LYCalendarPickerMenuDelegate> delegate;
/**
 展示nmenu
 */
- (void)show;

/**
 回调
 */
@property (nonatomic, copy) LYCalendarPickerMenuDidSelect didSelected;

/**
 消失
 */
- (void)dismiss;

/**
 是否显示灰色覆盖层 Default is YES
 */
@property (nonatomic, assign) BOOL showMaskView;


@end

NS_ASSUME_NONNULL_END
