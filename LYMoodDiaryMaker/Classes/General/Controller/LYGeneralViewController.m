//
//  LYGeneralViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/31.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGeneralViewController.h"
#import "LYAboutUsViewController.h"
#import "LYWKWebViewController.h"
#import "LYCustomNavgationBarView.h"
#import "LYSettingTableViewCell.h"

#import "LYNoviceManualViewController.h"
#import "LYCalendarMoodViewController.h"
#import "LYExportMoodViewController.h"
#import "LYPrivacyAgreementViewController.h"
#import "LYSettingViewController.h"
#import "LYGeneraPasscodeViewController.h"
#import "LYGeneralLanguageController.h"

@interface LYGeneralViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *typeArray;

@end

@implementation LYGeneralViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarView.leftBarItemImage = nil;
    self.title = LY_LocalizedString(@"kLYSettingTitle");
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];

    LYBaseCustomTableHeaderView *headerView = [[LYBaseCustomTableHeaderView alloc] init];
    headerView.title       = LY_LocalizedString(@"kLYSettingTitle");
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LYSettingTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYSettingTableViewCell *cell = [LYSettingTableViewCell cellWithTableView:tableView];
    cell.typeName = self.typeArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *typeName = self.typeArray[indexPath.row];
    if ([typeName isEqualToString:@"language"]) {
        //多语言
        LYGeneralLanguageController *languageVC = [[LYGeneralLanguageController alloc] init];
        [self.navigationController pushViewController:languageVC animated:YES];

    }else if ([typeName isEqualToString:@"search"]){
        //搜索
        
    }else if ([typeName isEqualToString:@"history"]) {
        //历史心情
        LYCalendarMoodViewController *historyVC = [[LYCalendarMoodViewController alloc] init];
        [self.navigationController pushViewController:historyVC animated:YES];
        
    }else if ([typeName isEqualToString:@"export"]){
        //导出
        LYExportMoodViewController *exportVC = [[LYExportMoodViewController alloc] init];
        [self presentViewController:exportVC animated:YES completion:nil];
        
    }else if ([typeName isEqualToString:@"noviceManual"]){
        //新手指南
        LYNoviceManualViewController *xinVC = [[LYNoviceManualViewController  alloc] init];
        [self.navigationController pushViewController:xinVC animated:YES];
    }else if ([typeName isEqualToString:@"star"]){
        //去评分
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1450481289"]];
        
    }else if ([typeName isEqualToString:@"protocol"]){
        //隐私协议
        LYPrivacyAgreementViewController *privacyVC = [[LYPrivacyAgreementViewController alloc] init];
        [self.navigationController pushViewController:privacyVC animated:YES];
        return;
    }else if ([typeName isEqualToString:@"aboutUs"]){
        LYSettingViewController *viewController = [[LYSettingViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if ([typeName isEqualToString:@"version"]){
        NSString *str = [NSString stringWithFormat: @"%@%@",LY_LocalizedString(@"kLYSettingCurrentVersion"),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [LYToastTool bottomShowWithText:str delay:1.f];
    }else if([typeName isEqualToString:@"passcode"]){
        
        LYGeneraPasscodeViewController *privacyVC = [[LYGeneraPasscodeViewController alloc] init];
        [self.navigationController pushViewController:privacyVC animated:YES];
        return;
    }
    
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


#pragma mark - lazy loadig

- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
        [_typeArray addObjectsFromArray:@[@"language",@"search",@"export",@"passcode",@"protocol",@"noviceManual",@"aboutUs"]];
    }
    return _typeArray;
}
@end

