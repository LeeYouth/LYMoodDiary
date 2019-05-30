//
//  LYMoodDiaryPreviewEmojiCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMoodDiaryPreviewEmojiCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight;
@property (nonatomic, strong) LYMoodDiaryModel *model;


@end

NS_ASSUME_NONNULL_END
