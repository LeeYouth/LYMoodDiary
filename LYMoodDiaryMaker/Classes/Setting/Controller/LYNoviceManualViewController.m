//
//  LYNoviceManualViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYNoviceManualViewController.h"
#import "LYNoviceManualTableViewCell.h"

@interface LYNoviceManualViewController ()

@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation LYNoviceManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.backgroundColor = tableViewBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = LY_LocalizedString(@"kLYSettingCellNovice");
    
    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    headView.title       = LY_LocalizedString(@"kLYSettingCellNovice");
    self.tableView.tableHeaderView = headView;
    
    [self.tableView reloadData];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYNoviceManualTableViewCell *cell = [LYNoviceManualTableViewCell cellWithTableView:tableView];
    cell.introStr = self.titleArray[indexPath.row];
    cell.type = indexPath.row;
    return cell;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        [_titleArray addObjectsFromArray:@[LY_LocalizedString(@"kLYHowToUseOne"),LY_LocalizedString(@"kLYHowToUseTwo")]];
    }
    return _titleArray;
}

@end
