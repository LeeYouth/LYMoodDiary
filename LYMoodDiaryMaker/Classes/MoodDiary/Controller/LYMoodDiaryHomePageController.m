//
//  LYMoodDiaryHomePageController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/24.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryHomePageController.h"
#import "LYMoodDiaryHomePageTableCell.h"
#import "LYMoodDiaryHomePageHeaderView.h"
#import "LYHomePageMenuButton.h"
#import "LYSettingViewController.h"
#import "LYMoodDiaryHomePageToolBar.h"

@interface LYMoodDiaryHomePageController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) LYBaseCustomTableHeaderView *headerView;

@end

@implementation LYMoodDiaryHomePageController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadTableData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubViews];

    [self loadNewData];
    
}
- (void)setupSubViews{
    self.navBarView.leftBarItemImage = nil;
    self.navBarView.navColor = [UIColor whiteColor];
    self.navBarView.rightBarItemImage = self.yesterday?nil:[UIImage imageNamed:@"homepage_rightBarItem"];
    
    
    self.tableView.backgroundColor = LYHomePageColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    NSDate *today   = [NSDate date];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:today];//前一天
    
    LYBaseCustomTableHeaderView *headerView = [[LYBaseCustomTableHeaderView alloc] init];
    headerView.title       = self.yesterday?LY_LocalizedString(@"kLYMoodYesterday"):LY_LocalizedString(@"kLYMoodToday");
    headerView.detailTitle = [self.yesterday?lastDay:today stringWithFormat:kHEADERDETAILTITLEDATEFORMAT];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;

    [self.view addSubview:self.addButton];
    
    CGFloat bottomM = kTabbarExtra + kLYContentLeftMargin;
    CGFloat buttonW = 56;
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonW));
        make.right.equalTo(self.view.mas_right).offset(-kLYContentLeftMargin);
        make.bottom.equalTo(self.view.mas_bottom).offset(-bottomM);
    }];
    
    CGFloat tableBottomM = self.yesterday?kTabbarExtra:(buttonW + bottomM);
    if (!self.yesterday) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, tableBottomM, 0);
    }

    self.addButton.hidden = self.yesterday;
    
    
    LYCustomEmptyDataView *customView = [[LYCustomEmptyDataView alloc] init];
    customView.title = LY_LocalizedString(@"kLYEmptyDataMessage");
//    customView.detailTitle = @"您可以在首页点击添加，选择您当前的心情，并用文字记录。";
//    customView.detailTitle = LY_NSLocalizedString(@"kLYMainEmptyDataMessage", nil);
    self.tableView.ly_emptyView  = [LYEmptyView emptyViewWithCustomView:customView];

}

- (void)reloadTableData{
    [self loadNewData];
}

- (void)loadNewData{
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    NSDate *today   = [NSDate date];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:today];//前一天
    
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"saveFormatDate"),bg_sqlValue([self.yesterday?lastDay:today stringWithFormat:@"yyyy-MM-dd"])];
    
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
            [weakSelf presentViewController:previewVC animated:YES completion:nil];
        }else if (index == 1){
            //删除
            [weakSelf deleteMoodWithModel:weakSelf.dataArray[indexPath.row]];
        }else if (index == 10001){
            //进入编辑
            [weakSelf editMoodWithModel:weakSelf.dataArray[indexPath.row]];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

#pragma makr - 跳转到编辑心情界面
- (void)editMoodWithModel:(LYMoodDiaryModel *)model{
    WEAKSELF(weakSelf);
    LYWriteMoodDiaryViewController *vc = [[LYWriteMoodDiaryViewController alloc] init];
    vc.editMoodArray = [NSMutableArray arrayWithObject:model];
    vc.isPush = YES;
    vc.itemBlock = ^(NSInteger index) {
        [weakSelf reloadTableData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma makr - 删除一条心情l记录
- (void)deleteMoodWithModel:(LYMoodDiaryModel *)model{

    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"enterDate"),bg_sqlValue(model.enterDate)];
    if ([LYMoodDiaryModel bg_delete:kLYMOODTABLENAME where:where]) {
        [self reloadTableData];
    }
}




- (void)rightBarItemClick{
    LYSettingViewController *settingVC = [[LYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)writeMoodDiaryAction{
    if (self.itemClick) {
        self.itemClick(0);
    }
}

#pragma mark - lazy loading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIButton *)addButton{
    return LY_LAZY(_addButton, ({
        UIButton *view = [[UIButton alloc] init];
        [view setBackgroundImage:[UIImage imageNamed:@"homepage_addMoodDiary"] forState:UIControlStateNormal];
        view.layer.cornerRadius = 56/2;
        view.layer.shadowOffset =  CGSizeMake(1, 1);
        view.layer.shadowOpacity = 0.3;
        view.layer.shadowColor =  [UIColor blackColor].CGColor;
        view.showsTouchWhenHighlighted = YES;
        [view addTarget:self action:@selector(writeMoodDiaryAction) forControlEvents:UIControlEventTouchUpInside];
        view;
    }));
}

@end
