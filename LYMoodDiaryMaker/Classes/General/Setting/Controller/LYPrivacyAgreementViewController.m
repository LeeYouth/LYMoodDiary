//
//  LYPrivacyAgreementViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/20.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYPrivacyAgreementViewController.h"
#import "LYPrivacyAgreementTableViewCell.h"

@implementation LYPrivacyAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = LY_LocalizedString(@"kLYSettingCellPrivacy");

    
    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    headView.title       = LY_LocalizedString(@"kLYSettingCellPrivacy");
    self.tableView.tableHeaderView = headView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYPrivacyAgreementTableViewCell *cell = [LYPrivacyAgreementTableViewCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end

