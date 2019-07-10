//
//  LYMoodDiaryHomePageController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/24.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryHomePageController.h"
#import "LYMoodDiaryHomePageHeaderView.h"
#import "LYMoodDiaryHomePageTableCell.h"
#import "LYCalendarPickerMenu.h"

@interface LYMoodDiaryHomePageController()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, weak) id <LYBaseCustomTableHeaderViewProtocol> headProtocol;

@end

@implementation LYMoodDiaryHomePageController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf);
    self.navBarView.leftBarItemImage = nil;
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
    
    self.tableView.backgroundColor = [UIColor tableViewColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    id<LYBaseCustomTableHeaderViewProtocol> obj = [[BeeHive shareInstance] createService:@protocol(LYBaseCustomTableHeaderViewProtocol)];
    self.headProtocol = obj;
    if ([obj isKindOfClass:[UIView class]]) {
        
        obj.title = [self.currentDate tableHeaderTitle];
        obj.detailTitle = [self.currentDate tableHeaderDetailTitle];
        
        self.tableView.tableHeaderView = (UIView *)obj;
    }
    
    self.title = [self.currentDate navigationTitle];
    
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
    LYMoodDiaryHomePageTableCell *cell = [LYMoodDiaryHomePageTableCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //进入预览
    [FFRouter routeURL:kMoodDiaryPreviewRouter withParameters:@{kRouterParamKey:self.dataArray[indexPath.row]}];
    
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

#pragma mark - 选择日期
- (void)calendarPickerDate{
    WEAKSELF(weakSelf);
    LYCalendarPickerMenu *menu = [[LYCalendarPickerMenu alloc] initRelyOnView:self.view];
    menu.showMaskView = NO;
    menu.didSelected  = ^(NSDate * _Nonnull didSelectDate) {
        weakSelf.headProtocol.title       = [didSelectDate tableHeaderTitle];
        weakSelf.headProtocol.detailTitle = [didSelectDate tableHeaderDetailTitle];
        
        weakSelf.currentDate = didSelectDate;
        weakSelf.title = [self.currentDate navigationTitle];
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

