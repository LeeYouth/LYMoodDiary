//
//  LYSettingTableViewCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/7.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSettingTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, copy) NSString *typeName;
+ (CGFloat)getCellHeight;

@end
