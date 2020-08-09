//
//  LYGeneralLanguageController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/4.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGeneralLanguageController.h"
#import "LYGeneralLanguageCell.h"
#import "LYMainRootViewController.h"

@interface LYGeneralLanguageController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, copy) NSString *defultLanguage;//默认语言

@end

@implementation LYGeneralLanguageController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.defultLanguage = [LYLocalizedConfig userLanguage] ? :@"defult";
    DKImagePicker picker = DKImagePickerWithNames(@"navBar_saveicon",@"navBar_saveicon-dark");

    self.title = LY_LocalizedString(@"kLYSettingCellLanguage");
    self.navBarView.rightBarItemImage = picker;
//    self.navBarView.rightItemTitle = LY_LocalizedString(@"kLYNavigationMoodSave");
    WEAKSELF(weakSelf);
    self.navBarView.btnBlock = ^(UIButton *sender) {
        [weakSelf.view endEditing:YES];
        if (sender.tag == 0) {
            //返回
            [weakSelf backAction];
            
        }else if (sender.tag == 1){
            //保存
            [weakSelf saveClickAction];
        }
    };
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    headView.title       = LY_LocalizedString(@"kLYSettingCellLanguage");
    self.tableView.tableHeaderView = headView;
    
    [self.tableView reloadData];
    
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
    cell.isCheck  = [typeName isEqualToString:self.defultLanguage];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.defultLanguage = self.typeArray[indexPath.row];
    [self.tableView reloadData];
    
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

- (void)saveClickAction{
    if ([self.defultLanguage isEqualToString:@"defult"]) {
        //跟随系统
        [LYLocalizedConfig setUserLanguage:nil];
    }else{
        //选择
        [LYLocalizedConfig setUserLanguage:self.defultLanguage];
    }

    //解决奇怪的动画bug。异步执行
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LYMainRootViewController alloc] init];

//        LYMainRootViewController *rootVC = [[LYMainRootViewController alloc] init];
//        LYTabbarViewController *tabBarController = rootVC.tabBarController;
//        tabBarController.selectedIndex = 1;
//        LYBaseNavigationController *nvc = tabBarController.selectedViewController;
//        NSMutableArray *vcs = nvc.viewControllers.mutableCopy;
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [vcs addObject:[[LYGeneralLanguageController alloc] init]];
//            [nvc setViewControllers:vcs];
//        });
//
        LYLog(@"已切换到语言 %@", [NSBundle currentLanguage]);
    });
}

#pragma mark - lazy loadig

- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
        [_typeArray addObjectsFromArray:@[@"defult"]];
        [_typeArray addObjectsFromArray:[NSBundle allLanguages]];
    }
    return _typeArray;
}

@end

