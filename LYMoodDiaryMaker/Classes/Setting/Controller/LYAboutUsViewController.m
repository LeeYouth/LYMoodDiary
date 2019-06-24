//
//  LYAboutUsViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYAboutUsViewController.h"
#import "LYAboutUsTableViewCell.h"

@interface LYAboutUsViewController ()

@end

@implementation LYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    [self exportAppTitle];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = LY_LocalizedString(@"kLYSettingCellSupport");

    id<LYBaseCustomTableHeaderViewProtocol> obj = [[BeeHive shareInstance] createService:@protocol(LYBaseCustomTableHeaderViewProtocol)];
    if ([obj isKindOfClass:[UIView class]]) {
        obj.title       = LY_LocalizedString(@"kLYSettingCellSupport");
        self.tableView.tableHeaderView = (UIView *)obj;
    }
}

- (void)exportAppTitle{
    //测试代码
    UIView *backView = [UIView new];
    backView.backgroundColor = [[UIColor themeButtonColor] colorWithAlphaComponent:0.3];
    backView.frame = CGRectMake(62, (kScreenHeight - 40)/2 + 46, kScreenWidth - 106, 40);
//    [self.view addSubview:backView];
    
    UILabel *view = [UILabel new];
    view.textColor = LYColor(LYBlackColorHex);
    view.textAlignment = NSTextAlignmentCenter;
    view.text = @"日記";
    view.font = [UIFont fontAliWithName:AlibabaPuHuiTiR size:150];
//    [self.view addSubview:view];
    view.frame = self.view.frame;
    
    UILabel *detailview = [UILabel new];
    detailview.textColor = LYColor(LYBlackColorHex);
    detailview.textAlignment = NSTextAlignmentCenter;
    detailview.text = @"记录美好心情";
    detailview.font = [UIFont fontAliWithName:AlibabaPuHuiTiL size:40];
    [self.view addSubview:detailview];
    detailview.frame = CGRectMake(0, 200, kScreenWidth, 100);
//    CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI/2);
//    detailview.transform = transform;
    self.tableView.hidden =YES;
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYAboutUsTableViewCell *cell = [LYAboutUsTableViewCell cellWithTableView:tableView];
    cell.introStr = @"    人生中每时每刻都在发生不同的事情，人的心情也会随着事物的变化而变化。心情日記帮您快速记录每时每刻的心情，心理历程。\n    时光是不可见的，但是心情日記记录的您的心情却是可见的。当您静下心来回想起自己的心情历史记录时，您可以通过心情日記查看！\n     心情日記备受用户好评的极简化设计风格，添加、编辑、导出非常方便，快捷！\n    立即与朋友分享心情日記，开启一段美好的心情日記体验吧。\n\n\n======联系我们======\n\n您在使用中遇到任何问题都可联系我们:281532697@qq.com";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
