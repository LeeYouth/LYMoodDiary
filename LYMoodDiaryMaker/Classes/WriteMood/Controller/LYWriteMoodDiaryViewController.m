//
//  LYWriteMoodDiaryViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/13.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYWriteMoodDiaryViewController.h"
#import "LYWriteMoodDiaryTableCell.h"
#import "LYWriteMoodDiaryAddEmojiCell.h"

@interface LYWriteMoodDiaryViewController ()

@property (nonatomic, strong) NSMutableArray *emojiArray;
@property (nonatomic, strong) LYBaseCustomTableHeaderView *headerView;
@property (nonatomic, strong) LYMoodDiaryModel *defultModel;

@end

@implementation LYWriteMoodDiaryViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
}
- (void)setupSubViews{
    
    WEAKSELF(weakSelf);
    self.navBarView.leftBarItemImage  = [UIImage imageNamed:@"navBar_closeicon"];
    self.navBarView.rightItemTitle = LY_LocalizedString(@"kLYNavigationMoodSave");
    self.navBarView.rightBarItemImage = nil;
    self.navBarView.navColor = [UIColor whiteColor];
    self.navBarView.btnBlock = ^(UIButton *sender) {
        [weakSelf.view endEditing:YES];
        if (sender.tag == 0) {
            //返回
            if (weakSelf.isPush) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                if (weakSelf.itemBlock) {
                    weakSelf.itemBlock(sender.tag);
                }
            }
            
        }else if (sender.tag == 1){
            if (weakSelf.isPush) {
                //编辑保存
                [weakSelf editMoodAction];
            }else{
                //保存操作
                [weakSelf saveMoodAction];
            }
            
        }
    };
    
    self.tableView.backgroundColor = LYHomePageColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self setupTableHeaderUI];
    
    [self.tableView reloadData];

}

#pragma mark - 编辑操作
- (void)editMoodAction{
    LYWriteMoodDiaryTableCell *textCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:1 inSection:0]];
    LYWriteMoodDiaryAddEmojiCell *emojiCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (!textCell.textView.text.length) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYRecordMoodAlertTitle") delay:1.f];
        return;
    }
    
    LYMoodDiaryModel *orgModel = (LYMoodDiaryModel *)self.editMoodArray[0];
    //保存操作
    LYMoodDiaryModel *model = [[LYMoodDiaryModel alloc] init];
    model.bg_tableName  = kLYMOODTABLENAME;
    model.editDate      = [NSDate date];
    model.moodType      = emojiCell.emojiType.length?[LYMoodDiaryModel matchTypeWithEmojiType:emojiCell.emojiType]:orgModel.moodType;
    model.moodDiaryText = textCell.textView.text;
    
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"enterDate"),bg_sqlValue(orgModel.enterDate)];

    if ([model bg_updateWhere:where]) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYMoodSaveSuccess") delay:1.f];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.itemBlock) {
                self.itemBlock(1);
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}


#pragma mark - 提交按钮
- (void)saveMoodAction{
  
    
    LYWriteMoodDiaryTableCell *textCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (!textCell.textView.text.length) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYRecordMoodAlertTitle") delay:1.f];
        return;
    }

    //保存操作
    LYMoodDiaryModel *model = [[LYMoodDiaryModel alloc] init];
    model.bg_tableName   = kLYMOODTABLENAME;

    model.enterDate     = self.defultModel.enterDate;
    model.uploadDate    = [NSDate date];
    model.moodType      = self.defultModel.moodType;
    model.moodDiaryText = textCell.textView.text;

    if ([model bg_save]) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYMoodSaveSuccess") delay:1.f];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.itemBlock) {
                self.itemBlock(1);
            }

            self.defultModel.moodType = LYMoodDiaryHappy;
            textCell.textView.text = @"";
            [self.tableView reloadData];
        });
    }

}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [LYWriteMoodDiaryAddEmojiCell getCellHeight];
    }
    return kScreenHeight - NAVBAR_HEIGHT - kTabbarExtra - [LYWriteMoodDiaryAddEmojiCell getCellHeight] - _headerView.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf);
    BOOL isEditMood = self.editMoodArray.count;
    
    LYMoodDiaryModel *model = isEditMood?(LYMoodDiaryModel *)self.editMoodArray[0]:self.defultModel;

    if (indexPath.row == 0) {
        LYWriteMoodDiaryAddEmojiCell *cell = [LYWriteMoodDiaryAddEmojiCell cellWithTableView:tableView];
        cell.model = model;
        cell.didSelected = ^(NSInteger index) {
            [weakSelf showMenuView];
        };
        return cell;
    }
    LYWriteMoodDiaryTableCell *cell = [LYWriteMoodDiaryTableCell cellWithTableView:tableView];
    cell.model = model;
    if (self.isPush) {
        [cell.textView becomeFirstResponder];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - 设置列表头部
- (void)setupTableHeaderUI{
    BOOL isEditMood = self.editMoodArray.count;
    
    LYBaseCustomTableHeaderView *headerView = [[LYBaseCustomTableHeaderView alloc] init];
    headerView.title       = isEditMood?LY_LocalizedString(@"kLYEditMoodTitle"):LY_LocalizedString(@"kLYRecordMoodTitle");
    headerView.detailTitle = isEditMood?LY_LocalizedString(@"kLYEditMoodDetail"):LY_LocalizedString(@"kLYRecordMoodDetail");
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
}

#pragma method
- (void)textViewBecomeFirstResponder{
    self.defultModel.enterDate = [NSDate date];
    [self setupTableHeaderUI];
    [self.tableView reloadData];

    LYWriteMoodDiaryTableCell *textCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:1 inSection:0]];
    [textCell.textView becomeFirstResponder];
    
}
- (void)textViewResignFirstResponder{
    BOOL isEditMood = self.editMoodArray.count;

    LYWriteMoodDiaryTableCell *textCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:1 inSection:0]];
    if (!isEditMood) {
        self.defultModel.moodDiaryText = textCell.textView.text;
    }
    [textCell.textView resignFirstResponder];
    
    if (isEditMood) {
        [self.editMoodArray removeAllObjects];
        [self.tableView reloadData];
    }
}

#pragma mark - 展示表情
- (void)showMenuView{
    WEAKSELF(weakSelf);
    LYWriteMoodDiaryAddEmojiCell *emojiCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    LYEmojiPopMenu *menu = [[LYEmojiPopMenu alloc] initRelyOnView:emojiCell.emojiImageView Emojis:self.emojiArray];
    menu.showMaskView = NO;
    __weak LYWriteMoodDiaryAddEmojiCell *weakCell = emojiCell;
    menu.didSelected = ^(NSInteger index) {
        if (weakSelf.editMoodArray.count) {
            weakCell.emojiType = weakSelf.emojiArray[index];
        }else{
            weakSelf.defultModel.moodType = [LYMoodDiaryModel matchTypeWithEmojiType:weakSelf.emojiArray[index]];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:NO];
        }
    };
    [menu show];
}


#pragma mark - lazy loading
- (NSMutableArray *)emojiArray{
    if (!_emojiArray) {
        _emojiArray = [NSMutableArray array];
//        NSArray *resurceArray = @[LYEMOJI_HAPPY,LYEMOJI_INLOVE,LYEMOJI_MAD,LYEMOJI_SAD,LYEMOJI_COOL,LYEMOJI_CRY,LYEMOJI_SLEEP,LYEMOJI_HUNGRY];
        NSArray *resurceArray = @[LYEMOJI_HAPPY,LYEMOJI_INLOVE,LYEMOJI_MAD,LYEMOJI_SAD,LYEMOJI_SLEEP];
        [_emojiArray addObjectsFromArray:resurceArray];

    }
    return _emojiArray;
}
- (LYMoodDiaryModel *)defultModel{
    if (!_defultModel) {
        _defultModel = [[LYMoodDiaryModel alloc] init];
        _defultModel.moodType  = LYMoodDiaryHappy;
        _defultModel.enterDate = [NSDate date];
    }
    return _defultModel;
}

@end

