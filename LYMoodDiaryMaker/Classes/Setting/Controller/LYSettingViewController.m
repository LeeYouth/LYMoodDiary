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
    
    self.navBarView.leftBarItemImage = [UIImage imageNamed:@"navBarBackItemIcon"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sloganView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.sloganView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TABBAR_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(86, 86));
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
    if ([typeName isEqualToString:@"history"]) {
        //历史心情
        LYCalendarMoodViewController *historyVC = [[LYCalendarMoodViewController alloc] init];
        historyVC.leftItemImage = @"navBarBackItemIcon";
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
        LYAboutUsViewController *viewController = [[LYAboutUsViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if ([typeName isEqualToString:@"version"]){
        NSString *str = [NSString stringWithFormat: @"%@%@",LY_LocalizedString(@"kLYSettingCurrentVersion"),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [LYToastTool bottomShowWithText:str delay:1.f];
    }

    
}
#pragma mark - lazy loadig
- (UITableView *)tableView{
    return LY_LAZY(_tableView, ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view;
    }));
}

- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
        [_typeArray addObjectsFromArray:@[@"history",@"export",@"noviceManual",@"star",@"protocol",@"aboutUs",@"version"]];
    }
    return _typeArray;
}
@end

