//
//  LYSettingViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYSettingViewController.h"
#import "LYWKWebViewController.h"
#import "LYSettingTableViewCell.h"

#import "LYCalendarMoodViewController.h"
#import "LYExportMoodViewController.h"

@interface LYSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

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
    
    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    headView.title       = LY_LocalizedString(@"kLYSettingCellAbout");
    self.tableView.tableHeaderView = headView;
    
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
        [self.navigationController pushViewController:historyVC animated:YES];

    }else if ([typeName isEqualToString:@"export"]){
        //导出
        LYExportMoodViewController *exportVC = [[LYExportMoodViewController alloc] init];
        [self presentViewController:exportVC animated:YES completion:nil];

    }else if ([typeName isEqualToString:@"star"]){
        //去评分
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1450481289"]];

    }else if ([typeName isEqualToString:@"support"]){
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_PushWKWebViewController:@{@"url":LY_LocalizedString(@"kLYSettingCellSupportURL"),
                                                                                                 @"title":LY_LocalizedString(@"kLYSettingCellSupport")
        }];
        [self.navigationController pushViewController:vc animated:YES];
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

