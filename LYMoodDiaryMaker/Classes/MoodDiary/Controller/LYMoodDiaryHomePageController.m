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
    
    if (![kUserDefault boolForKey:kHOMEPAGEGUIDEINDENTIFER]) {
        LYHomepageGuideView *guidView = [[LYHomepageGuideView alloc] initWithGuideType:kHOMEPAGEGUIDEINDENTIFER];
        guidView.title = LY_LocalizedString(@"kLYHomePageGuideTitle");
        guidView.iconImage = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYResources.bundle", @"homepage_guide_icon")];
        [guidView show];
    }
    
    self.navBarView.leftBarItemImage = nil;
    self.navBarView.navColor = [UIColor whiteColor];
    self.navBarView.rightBarItemImage = nil;
    self.title = LY_LocalizedString(@"kLYMoodToday");
    
    self.tableView.backgroundColor = LYHomePageColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSDate *today   = [NSDate date];
    
    LYBaseCustomTableHeaderView *headerView = [[LYBaseCustomTableHeaderView alloc] init];
    headerView.title       = LY_LocalizedString(@"kLYMoodToday");
    headerView.detailTitle = [today stringWithFormat:kHEADERDETAILTITLEDATEFORMAT];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
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
    
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"saveFormatDate"),bg_sqlValue([today stringWithFormat:@"yyyy-MM-dd"])];
    
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
    CGFloat offsetY = point.y;
    CGFloat tabbarH = TABBAR_HEIGHT;

    if (offsetY < 0) {
        /// 上滑
        CYLTabBarController *tabBarController = [self cyl_tabBarController];
        [UIView animateWithDuration:0.35 animations:^{
            tabBarController.tabBar.frame = CGRectMake(0, kScreenHeight, kScreenWidth, tabbarH);
        }];
    } else {
        /// 下滑
        CYLTabBarController *tabBarController = [self cyl_tabBarController];
        [UIView animateWithDuration:0.35 animations:^{
            tabBarController.tabBar.frame = CGRectMake(0, kScreenHeight - tabbarH, kScreenWidth, tabbarH);
        }];
    }
    CGFloat offset = scrollView.contentOffset.y;

    if (offset >= NAVBAR_HEIGHT) {
        self.navBarView.navBarTitle = self.title;
        self.navBarView.showShadow  = YES;
    }else{
        self.navBarView.navBarTitle = @"";
        self.navBarView.showShadow  = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    CGFloat tabbarH = TABBAR_HEIGHT;

    [UIView animateWithDuration:0.35 animations:^{
        tabBarController.tabBar.frame = CGRectMake(0, kScreenHeight - tabbarH, kScreenWidth, tabbarH);
    }];
}

#pragma makr - 跳转到编辑心情界面
- (void)editMoodWithModel:(LYMoodDiaryModel *)model{
    WEAKSELF(weakSelf);
    LYWriteMoodDiaryViewController *vc = [[LYWriteMoodDiaryViewController alloc] init];
    vc.editMoodArray = [NSMutableArray arrayWithObject:model];
    vc.itemBlock = ^(NSInteger index) {
        [weakSelf reloadTableData];
    };
    [self presentViewController:vc animated:YES completion:nil];
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

#pragma mark - lazy loading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
