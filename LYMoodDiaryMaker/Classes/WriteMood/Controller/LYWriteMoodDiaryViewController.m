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
#import "LYWriteMoodDiaryGuideView.h"

@interface LYWriteMoodDiaryViewController ()

@property (nonatomic, strong) NSMutableArray *emojiArray;
@property (nonatomic, strong) LYBaseCustomTableHeaderView *headerView;
@property (nonatomic, strong) LYMoodDiaryModel *defultModel;

@end

@implementation LYWriteMoodDiaryViewController

@synthesize editMoodArray =_editMoodArray;
@synthesize itemBlock = _itemBlock;


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![kUserDefault boolForKey:@"LYWriteMoodDiaryGuideView"]) {
        [self.view endEditing:YES];
        LYWriteMoodDiaryGuideView *guideView = [[LYWriteMoodDiaryGuideView alloc] initWithGuideType:@"LYWriteMoodDiaryGuideView"];
        guideView.iconImage = [UIImage imageNamed:@"writeMood_guide"];
        guideView.title     = LY_LocalizedString(@"kLYWriteMoodGuideTitle");
        [guideView show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubViews];
    
}
- (void)setupSubViews{
    
    WEAKSELF(weakSelf);
    DKImagePicker picker = DKImagePickerWithNames(@"navBar_closeicon",@"navBar_closeicon-dark");
    DKImagePicker picker1 = DKImagePickerWithNames(@"navBar_saveicon",@"navBar_saveicon-dark");

    self.navBarView.leftBarItemImage  = picker;
    self.navBarView.rightBarItemImage = picker1;
    self.navBarView.navColor = bgColor;
    self.navBarView.btnBlock = ^(UIButton *sender) {
        [weakSelf.view endEditing:YES];
        if (sender.tag == 0) {
            //返回
            [weakSelf backAction];

        }else if (sender.tag == 1){
            
            if (weakSelf.editMoodArray.count) {
                //编辑保存
                [weakSelf editMoodAction];
            }else{
                //保存操作
                [weakSelf saveMoodAction];
            }
            
        }
    };
    
    self.tableView.dk_backgroundColorPicker = tableViewBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self setupTableHeaderUI];
    
    [self.tableView reloadData];
    
    [self textViewBecomeFirstResponder];

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
    model.editDate      = [NSDate date];
    model.moodType      = emojiCell.emojiType.length?[LYMoodDiaryModel matchTypeWithEmojiType:emojiCell.emojiType]:orgModel.moodType;
    model.moodDiaryText = textCell.textView.text;
    
    if ([LYMoodDiaryDBManager updateMoodDiaryWithOrgModel:orgModel updateModel:model]) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYMoodSaveSuccess") delay:1.f];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.itemBlock) {
                self.itemBlock(1);
            }
            [self backAction];
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
    model.enterDate     = self.defultModel.enterDate;
    model.uploadDate    = [NSDate date];
    model.moodType      = self.defultModel.moodType;
    model.moodDiaryText = textCell.textView.text;

    if ([LYMoodDiaryDBManager saveMoodDiaryWithModel:model]) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYMoodSaveSuccess") delay:1.f];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.itemBlock) {
                self.itemBlock(1);
            }
            [self backAction];

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
    if ([kUserDefault boolForKey:@"LYWriteMoodDiaryGuideView"]) {
        [cell.textView becomeFirstResponder];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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

#pragma mark - 设置列表头部
- (void)setupTableHeaderUI{
    BOOL isEditMood = self.editMoodArray.count;
    
    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    headView.title = isEditMood?LY_LocalizedString(@"kLYEditMoodTitle"):LY_LocalizedString(@"kLYRecordMoodTitle");
    headView.detailTitle = isEditMood?LY_LocalizedString(@"kLYEditMoodDetail"):LY_LocalizedString(@"kLYRecordMoodDetail");
    self.tableView.tableHeaderView = headView;
    self.headerView = headView;
    

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
    LYWriteMoodDiaryTableCell *textCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:1 inSection:0]];
    [textCell.textView resignFirstResponder];
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

