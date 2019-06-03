//
//  LYSettingViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYSettingViewController.h"
#import "LYAboutUsViewController.h"
#import "LYWKWebViewController.h"
#import "LYCustomNavgationBarView.h"
#import "LYSettingTableViewCell.h"

#import "LYNoviceManualViewController.h"
#import "LYCalendarMoodViewController.h"
#import "LYExportMoodViewController.h"
#import "LYPrivacyAgreementViewController.h"

@interface LYSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *sloganView;
@property (nonatomic, strong) NSMutableArray *typeArray;

@end

@implementation LYSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    LYBaseCustomTableHeaderView *headerView = [[LYBaseCustomTableHeaderView alloc] init];
    headerView.title       = LY_LocalizedString(@"kLYSettingCellAbout");
    self.tableView.tableHeaderView = headerView;
    self.title = LY_LocalizedString(@"kLYSettingCellAbout");
    
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
    if ([typeName isEqualToString:@"history"]) {
        //历史心情
        LYCalendarMoodViewController *historyVC = [[LYCalendarMoodViewController alloc] init];
        historyVC.leftItemImage = @"navBar_backItemIcon";
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
    }else if ([typeName isEqualToString:@"support"]){
        LYAboutUsViewController *viewController = [[LYAboutUsViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if ([typeName isEqualToString:@"version"]){
        NSString *str = [NSString stringWithFormat: @"%@%@",LY_LocalizedString(@"kLYSettingCurrentVersion"),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [LYToastTool bottomShowWithText:str delay:1.f];
    }

    
}
#pragma mark - lazy loadig
- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
        [_typeArray addObjectsFromArray:@[@"star",@"support",@"version"]];
    }
    return _typeArray;
}
@end

