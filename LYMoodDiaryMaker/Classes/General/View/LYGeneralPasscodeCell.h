//
//  LYGeneralPasscodeCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYGeneralPasscodeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, copy) LYViewDidSelected didSelect;

@end

NS_ASSUME_NONNULL_END
