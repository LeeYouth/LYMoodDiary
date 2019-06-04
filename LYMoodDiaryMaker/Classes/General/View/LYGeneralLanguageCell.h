//
//  LYGeneralLanguageCell.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/4.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYGeneralLanguageCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, copy) NSString *typeName;
@property(nonatomic, assign) BOOL isCheck;

@end

NS_ASSUME_NONNULL_END
