//
//  LYMoodDiaryPreviewTextCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMoodDiaryPreviewTextCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) LYMoodDiaryModel *model;

@end

NS_ASSUME_NONNULL_END
