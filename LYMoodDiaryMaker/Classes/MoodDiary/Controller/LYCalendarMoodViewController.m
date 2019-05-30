//
//  LYCalendarMoodViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/15.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYCalendarMoodViewController.h"
#import "LYMoodDiaryHomePageHeaderView.h"
#import "LYMoodDiaryHomePageTableCell.h"
#import "LYCalendarPickerMenu.h"

@interface LYCalendarMoodViewController()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LYBaseCustomTableHeaderView *headerView;
@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation LYCalendarMoodViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf);
    self.navBarView.leftBarItemImage  = [UIImage imageNamed:self.leftItemImage.length?self.leftItemImage:@"navBar_closeicon"];
    self.navBarView.navColor = [UIColor whiteColor];
    self.navBarView.rightBarItemImage = [UIImage imageNamed:@"homepage_addMoodDiary_calendar"];
    self.navBarView.btnBlock = ^(UIButton *sender) {
        if (sender.tag == 0) {
            //返回
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else if (sender.tag == 1){
            //日历
            [weakSelf calendarPickerDate];
        }
    };
    
    self.tableView.backgroundColor = LYHomePageColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    LYBaseCustomTableHeaderView *headerView = [[LYBaseCustomTableHeaderView alloc] init];
    headerView.title       = [[NSDate date] stringWithFormat:kHEADERTITLEDATEFORMAT];
    headerView.detailTitle = [[NSDate date] stringWithFormat:kHEADERDETAILTITLEDATEFORMAT];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    LYCustomEmptyDataView *customView = [[LYCustomEmptyDataView alloc] init];
    customView.title = LY_LocalizedString(@"kLYEmptyDataMessage");
    self.tableView.ly_emptyView  = [LYEmptyView emptyViewWithCustomView:customView];

    [self loadNewData];
}

- (void)loadNewData{
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    NSDate *today   = self.currentDate;
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"saveFormatDate"),bg_sqlValue([today stringWithFormat:kSEARCHDATEFORMAT])];
    
    NSArray *resultArray = [LYMoodDiaryModel bg_find:kLYMOODTABLENAME where:where];
    [self.dataArray addObjectsFromArray:resultArray];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LYMoodDiaryHomePageTableCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf);
    LYMoodDiaryHomePageTableCell *cell = [LYMoodDiaryHomePageTableCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.didSelected = ^(NSInteger index) {
        if (index == 0) {
            //预览
            LYMoodDiaryPreviewViewController *previewVC = [[LYMoodDiaryPreviewViewController alloc] init];
            previewVC.previewModel = weakSelf.dataArray[indexPath.row];
            [weakSelf.navigationController presentViewController:previewVC animated:YES completion:nil];
        }else if (index == 1){
            //删除
            [weakSelf deleteMoodWithModel:weakSelf.dataArray[indexPath.row]];
        }else if (index == 10001){
            //进入编辑
            [weakSelf editMoodWithModel:self.dataArray[indexPath.row]];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    [self editMoodWithModel:self.dataArray[indexPath.row]];
}

#pragma makr - 跳转到编辑心情界面
- (void)editMoodWithModel:(LYMoodDiaryModel *)model{
    WEAKSELF(weakSelf);
    LYWriteMoodDiaryViewController *vc = [[LYWriteMoodDiaryViewController alloc] init];
    vc.editMoodArray = [NSMutableArray arrayWithObject:model];
    vc.isPush = YES;
    vc.itemBlock = ^(NSInteger index) {
        [weakSelf loadNewData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma makr - 删除一条心情l记录
- (void)deleteMoodWithModel:(LYMoodDiaryModel *)model{
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"enterDate"),bg_sqlValue(model.enterDate)];
    if ([LYMoodDiaryModel bg_delete:kLYMOODTABLENAME where:where]) {
        [self loadNewData];
    }
}

#pragma mark - 选择日期
- (void)calendarPickerDate{
    WEAKSELF(weakSelf);
    LYCalendarPickerMenu *menu = [[LYCalendarPickerMenu alloc] initRelyOnView:self.view];
    menu.showMaskView = NO;
    menu.didSelected  = ^(NSDate * _Nonnull didSelectDate) {
        weakSelf.headerView.title       = [didSelectDate stringWithFormat:kHEADERTITLEDATEFORMAT];
        weakSelf.headerView.detailTitle = [didSelectDate stringWithFormat:kHEADERDETAILTITLEDATEFORMAT];
        weakSelf.currentDate = didSelectDate;
        [weakSelf loadNewData];
    };
    [menu show];
}


#pragma mark - lazy loading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSDate *)currentDate{
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

@end

