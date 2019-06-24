//
//  LYGeneraPasscodeViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/31.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGeneraPasscodeViewController.h"
#import "LYGeneralPasscodeCell.h"
#import "LYGeneralPasscodeSectionHeader.h"
#import "LYCustomPasscodeViewController.h"

@interface LYGeneraPasscodeViewController ()<LYPasscodeViewControllerDelegate>

@end

@implementation LYGeneraPasscodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LY_LocalizedString(@"kLYSettingCellPasscode");
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = LYTableViewBackColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    id <LYBaseCustomTableHeaderViewProtocol> obj = [[BeeHive shareInstance] createService:@protocol(LYBaseCustomTableHeaderViewProtocol)];
    if ([obj isKindOfClass:[UIView class]]) {
        obj.title = LY_LocalizedString(@"kLYSettingCellPasscode");
        self.tableView.tableHeaderView = (UIView *)obj;
    }    
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    LYGeneralPasscodeSectionHeader *headView = [[LYGeneralPasscodeSectionHeader alloc] init];
    if (section == 0) {
        headView.title = LY_LocalizedString(@"kLYGeneralPasscodeRemind");
        headView.detailTitle = LY_LocalizedString(@"kLYGeneralPasscodeRemindDetail");
    }else{
        headView.title = @"";
        headView.detailTitle = LY_LocalizedString(@"kLYGeneralPasscodeYourTouchID");
    }
    return headView.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LYGeneralPasscodeSectionHeader *headView = [[LYGeneralPasscodeSectionHeader alloc] init];
    if (section == 0) {
        headView.title = LY_LocalizedString(@"kLYGeneralPasscodeRemind");
        headView.detailTitle = LY_LocalizedString(@"kLYGeneralPasscodeRemindDetail");
    }else{
        headView.title = @"";
        headView.detailTitle = LY_LocalizedString(@"kLYGeneralPasscodeYourTouchID");
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WEAKSELF(weakSelf);
    LYGeneralPasscodeCell *cell = [LYGeneralPasscodeCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.didSelect = ^(NSInteger index) {
        if (index == 10000) {
            [weakSelf.tableView reloadData];
        }else if (index == 10001){
            //首次去设置密码
            [weakSelf passcodeActionWithType:LYPasscodeViewControllerNewPasscodeType];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL switchOn = [LYPasscodeManager passcodeSwitchOn];
    BOOL hasPasscode = [LYPasscodeManager hasSetPasscode];

    if (indexPath.section == 0 && indexPath.row == 1 && switchOn && hasPasscode) {
        //修改密码
        [self passcodeActionWithType:LYPasscodeViewControllerChangePasscodeType];
    }
    
}


- (void)passcodeActionWithType:(LYPasscodeViewControllerType)type{
    LYCustomPasscodeViewController *viewController = [[LYCustomPasscodeViewController alloc] initWithNibName:nil bundle:nil];;
    viewController.delegate = self;
    viewController.type = type;
    // Passcode style (numeric or ASCII)
    viewController.passcodeStyle = LYPasscodeInputViewNormalPasscodeStyle;
    
    // Setup Touch ID manager
//    LYTouchIDManager *touchIDManager = [[LYTouchIDManager alloc] initWithKeychainServiceName:LYTouchIDManagerPasscodeAccountName];
//    touchIDManager.promptText = @"Touch ID";
//    viewController.touchIDManager = touchIDManager;
    
    if (viewController.type == LYPasscodeViewControllerCheckPasscodeType) {
        
        // To prevent duplicated selection before showing Touch ID user interface.
        self.tableView.userInteractionEnabled = NO;
        
        // Show Touch ID user interface
        [viewController startTouchIDAuthenticationIfPossible:^(BOOL prompted) {
            
            // Enable user interaction
            self.tableView.userInteractionEnabled = YES;
            
            // If Touch ID is unavailable or disabled, present passcode view controller for manual input.
            if (prompted) {
                NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
                if (selectedIndexPath) {
                    [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
                }
            } else {
                [self presentViewController:viewController animated:YES completion:nil];
            }
        }];
        
    } else {
        
        [self presentViewController:viewController animated:YES completion:nil];
    }

}

- (void)passcodeViewCloseButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - LYPasscodeViewControllerDelegate

- (void)passcodeViewController:(LYPasscodeViewController *)aViewController authenticatePasscode:(NSString *)aPasscode resultHandler:(void (^)(BOOL))aResultHandler{
    //
    if ([aPasscode isEqualToString:[LYPasscodeManager getOldPasscode]]) {
        aResultHandler(YES);
    } else {
        aResultHandler(NO);
    }
}

- (void)passcodeViewControllerDidFailAttempt:(LYPasscodeViewController *)aViewController{

    //验证失败
}

- (NSUInteger)passcodeViewControllerNumberOfFailedAttempts:(LYPasscodeViewController *)aViewController
{
    return 0;
}

- (NSDate *)passcodeViewControllerLockUntilDate:(LYPasscodeViewController *)aViewController
{
    return nil;
}

- (void)passcodeViewController:(LYPasscodeViewController *)aViewController didFinishWithPasscode:(NSString *)aPasscode{
    switch (aViewController.type) {
        case LYPasscodeViewControllerNewPasscodeType:
        {
            //首次设置密码
            [LYPasscodeManager savePasscodeWithPasscode:aPasscode];
            [kUserDefault setBool:YES forKey:kHASOPENPASSCODESWITCH];
            [kUserDefault synchronize];
            [self.tableView reloadData];
        }
            break;
        case LYPasscodeViewControllerChangePasscodeType:
        {
            //更新密码
            [LYPasscodeManager savePasscodeWithPasscode:aPasscode];
            [self.tableView reloadData];
        }
            break;
        case LYPasscodeViewControllerCheckPasscodeType:
        {
            
        }
            break;
        default:
            break;
    }
    
    [aViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
