//
//  LYWriteMoodDiaryAddEmojiCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/15.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYWriteMoodDiaryAddEmojiCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight;
@property (nonatomic, copy) LYViewDidSelected didSelected;
@property (nonatomic, strong) UIImageView *emojiImageView;
@property (nonatomic, copy) NSString *emojiType;
@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, strong) LYMoodDiaryModel *model;


@end

NS_ASSUME_NONNULL_END
