//
//  LYNoviceManualTableViewCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/8.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  新手指南cell

#import <UIKit/UIKit.h>

@interface LYNoviceManualTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, copy) NSString *introStr;
@property(nonatomic, assign) NSInteger type;

@end
