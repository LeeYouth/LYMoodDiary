//
//  LYMoodDiaryHomePageTableCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMoodDiaryHomePageTableCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight;
@property (nonatomic, strong) LYMoodDiaryModel *model;
@property (nonatomic, copy) LYViewDidSelected didSelected;

@end

NS_ASSUME_NONNULL_END
