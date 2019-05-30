//
//  LYActionSheet.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYActionSheetViewCell;

NS_ASSUME_NONNULL_BEGIN

@interface LYActionSheet : UIView


- (instancetype)initWithSheetTitles:(NSArray *)sheetTitles;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/**
 展示nmenu
 */
- (void)show;

/**
 回调
 */
@property (nonatomic, copy) LYViewDidSelected didSelected;

/**
 消失
 */
- (void)dismiss;

/**
 是否显示灰色覆盖层 Default is YES
 */
@property (nonatomic, assign) BOOL showMaskView;

@end

#pragma mark - 自定义的MTActionSheetView的cell
@interface LYActionSheetViewCell : UITableViewCell

/** 初始化类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) BOOL isCancel;

@end

NS_ASSUME_NONNULL_END
