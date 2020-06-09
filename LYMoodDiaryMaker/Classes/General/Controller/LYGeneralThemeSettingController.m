//
//  LYGeneralThemeSettingController.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/8.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "LYGeneralThemeSettingController.h"
#import "LYGeneralLanguageCell.h"

@interface LYGeneralThemeSettingController ()
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, copy) NSString *currentType;
@end

@implementation LYGeneralThemeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAKSELF(weakSelf);
    self.navBarView.btnBlock = ^(UIButton *sender) {
        [weakSelf.view endEditing:YES];
        if (sender.tag == 0) {
            //返回
            [weakSelf backAction];
        }
    };
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.title = LY_LocalizedString(@"kLYSettingCellDarkModel");
    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    headView.title       = LY_LocalizedString(@"kLYSettingCellDarkModel");
    self.tableView.tableHeaderView = headView;
    
    [self.tableView reloadData];
    
    NSString *type = [kUserDefault valueForKey:@"LYDarkModel"];
    if (type.length == 0) {
        self.currentType = @"flowSystem";
    }else{
        self.currentType = type;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(appWillEnterForeground)
                                                  name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(appDidEnterBackground)
                                                  name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *typeName = self.typeArray[indexPath.row];
    LYGeneralLanguageCell *cell = [LYGeneralLanguageCell cellWithTableView:tableView];
    cell.typeName = typeName;
    cell.isCheck  = [typeName isEqualToString:self.currentType];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *typeName = self.typeArray[indexPath.row];
    self.currentType = typeName;
    [kUserDefault setValue:typeName forKey:@"LYDarkModel"];
    [kUserDefault synchronize];
    if (indexPath.row == 0) {
        if (@available(iOS 13.0, *)) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                [self setThemeLight];
            }else {
                [self setThemeDark];
            }
        }else{
            [self setThemeLight];
        }
    }else if (indexPath.row == 1) {
        [self setThemeLight];
    }else if(indexPath.row == 2){
        [self setThemeDark];
    }

    [self.tableView reloadData];
}

- (void)appDidEnterBackground
{

}

//- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    [super traitCollectionDidChange:previousTraitCollection];
//    if (@available(iOS 13.0, *)) {
//        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
//            [self setThemeLight];
//        }else {
//            [self setThemeDark];
//        }
//    }else{
//        [self setThemeLight];
//    }
//}

- (void)appWillEnterForeground
{
    
}


- (void)setThemeDark
{
    [self.dk_manager nightFalling];
}

- (void)setThemeLight
{
    [self.dk_manager dawnComing];
}

#pragma mark - 返回操作
- (void)backAction{
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

#pragma mark - lazy loadig

- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
        [_typeArray addObjectsFromArray:@[@"flowSystem",@"night",@"dark"]];
    }
    return _typeArray;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
