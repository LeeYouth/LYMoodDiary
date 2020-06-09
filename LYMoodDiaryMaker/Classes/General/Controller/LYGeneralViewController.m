//
//  LYGeneralViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/31.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGeneralViewController.h"
#import "LYSettingTableViewCell.h"

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
    
    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    headView.title       = LY_LocalizedString(@"kLYSettingTitle");
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
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_GeneralLanguageController];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([typeName isEqualToString:@"search"]){
        //搜索
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_GenneralSearchViewController];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([typeName isEqualToString:@"history"]) {
        //历史心情
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_CalendarMoodViewController];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([typeName isEqualToString:@"export"]){
        //导出
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_ExportMoodViewController];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else if ([typeName isEqualToString:@"darkModel"]){
        //夜间模式
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_GeneralThemeSettingController];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([typeName isEqualToString:@"noviceManual"]){
        //新手指南 
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_PushWKWebViewController:@{@"url":LY_LocalizedString(@"kLYSettingCellNoviceURL"),
                                                                                                 @"title":LY_LocalizedString(@"kLYSettingCellNovice")
        }];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([typeName isEqualToString:@"protocol"]){
        //隐私协议
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_PushWKWebViewController:@{@"url":LY_LocalizedString(@"kLYSettingCellPrivacyURL"),
                                                                                                 @"title":LY_LocalizedString(@"kLYSettingCellPrivacy")
        }];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else if ([typeName isEqualToString:@"aboutUs"]){
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_SettingViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([typeName isEqualToString:@"version"]){
        NSString *str = [NSString stringWithFormat: @"%@%@",LY_LocalizedString(@"kLYSettingCurrentVersion"),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [LYToastTool bottomShowWithText:str delay:1.f];
    }else if([typeName isEqualToString:@"passcode"]){
        
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_GeneraPasscodeViewController];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (UIViewController *)instanceOfViewController:(NSString *)aClassName
{
    Class aClass = NSClassFromString(aClassName);
    if(aClass){
        return (UIViewController *)[[aClass alloc] init];
    }
    LYLog(@"Undefined class '%@'", aClassName);
    return nil;
}

- (void)performSelector:(NSObject*)vc selector:(NSString*)selector withObject:(id)object{
    if(!vc){
        LYLog(@"调用异常");
        return;
    }
    SEL aSelector = NSSelectorFromString(selector);
    if ([vc respondsToSelector:aSelector]) {
        if(object == nil){
            ((void (*)(id, SEL))[vc methodForSelector:aSelector])(vc, aSelector);
        }
        else{
            ((void (*)(id, SEL, id))[vc methodForSelector:aSelector])(vc, aSelector, object);
        }
    }
    else{
#if DEBUG
        NSString *reason = [NSString stringWithFormat:@"%@实例无法调用Setter方法(%@)", NSStringFromClass([vc class]), NSStringFromSelector(aSelector)];
        LYLog(@"%@", reason);
        [[NSException exceptionWithName:@"方法调用异常" reason:reason userInfo:@{}] raise];
#endif
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
        //,@"search",@"darkModel"
        [_typeArray addObjectsFromArray:@[@"language",@"export",@"passcode",@"protocol",@"noviceManual",@"aboutUs"]];
    }
    return _typeArray;
}
@end

