//
//  LYAboutUsTableViewCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/20.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAboutUsTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, copy) NSString *introStr;

@end

NS_ASSUME_NONNULL_END
