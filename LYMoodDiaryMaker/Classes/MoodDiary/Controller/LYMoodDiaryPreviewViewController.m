//
//  LYMoodDiaryPreviewViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryPreviewViewController.h"
#import "LYMoodDiaryPreviewEmojiCell.h"
#import "LYMoodDiaryPreviewTextCell.h"

@interface LYMoodDiaryPreviewViewController()

@property (nonatomic, strong) LYBaseCustomTableHeaderView *headView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LYMoodDiaryPreviewViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //数据加载
    [self loadData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf);
    DKImagePicker picker = DKImagePickerWithNames(@"homepage_rightBarItem",@"homepage_rightBarItem");

    self.navBarView.rightBarItemImage = picker;
    self.navBarView.navColor = bgColor;
    self.navBarView.btnBlock = ^(UIButton *sender) {
        if (sender.tag == 0) {
            //返回
            [weakSelf backButtonAction];
            
        }else if (sender.tag == 1){
            //功能
            [weakSelf rightBarItemAction];
        }
    };
    self.tableView.dk_backgroundColorPicker = tableViewBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    

    LYBaseCustomTableHeaderView *headView = [[LYBaseCustomTableHeaderView alloc] init];
    self.headView = headView;
    self.tableView.tableHeaderView = headView;
    
}

#pragma mark - 数据加载
- (void)loadData{
    
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"enterDate"),bg_sqlValue(self.creatDate)];
    
    NSArray *resultArray = [LYMoodDiaryModel bg_find:kLYMOODTABLENAME where:where];
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:resultArray];
    
    if (self.dataArray.count) {
        LYMoodDiaryModel *model = (LYMoodDiaryModel *)self.dataArray[0];
        self.headView.title       = [model.enterDate tableHeaderTitle];
        self.headView.detailTitle = [model.enterDate tableHeaderDetailTitle];
        self.tableView.tableHeaderView = self.headView;
        self.title = [model.enterDate navigationTitle];
        [self.tableView reloadData];
    }
   
}



#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [LYMoodDiaryPreviewEmojiCell getCellHeight];
    }
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYMoodDiaryModel *model = (LYMoodDiaryModel *)self.dataArray[0];
    if (indexPath.row == 0) {
        LYMoodDiaryPreviewEmojiCell *cell = [LYMoodDiaryPreviewEmojiCell cellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
    LYMoodDiaryPreviewTextCell *cell = [LYMoodDiaryPreviewTextCell cellWithTableView:tableView];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - 左侧按钮点击
- (void)backButtonAction{
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

#pragma mark  - 右侧按钮点击
- (void)rightBarItemAction{
    
    WEAKSELF(weakSelf);
    LYActionSheet *sheetView = [[LYActionSheet alloc] initWithSheetTitles:@[LY_LocalizedString(@"kLYSheetShareWechatTimeLine"),LY_LocalizedString(@"kLYSheetEdit"),LY_LocalizedString(@"kLYSheetDelete")]];
    sheetView.didSelected = ^(NSInteger index) {
        if (index == 0) {
            //生成长图
            [weakSelf saveLongImageAction];
        }else if (index == 1){
            //编辑
            [weakSelf editMoodWithModel];
        }else if (index == 2){
            //删除
            [weakSelf deleteMoodAction];
        }
    };
    [sheetView show];

}

#pragma mark - 生成长图
- (void)saveLongImageAction{
    //save to photosAlbum
    WEAKSELF(weakSelf);
    [LYToastTool showLoadingWithStatus:@""];
    [LYSnapshotManager screenShotForTableView:self.tableView finishBlock:^(UIImage * _Nonnull snapShotImage) {
        [LYToastTool dismiss];
        
//        [LYShareTool shareImage:snapShotImage toPlatformType:UMSocialPlatformType_WechatTimeLine];

        
//        UIImageWriteToSavedPhotosAlbum(snapShotImage, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *barItemTitle = @"保存成功";
    if (error != nil) {
        barItemTitle = @"保存失败";
    }
    [LYToastTool bottomShowWithText:barItemTitle delay:1.f];
}


#pragma makr - 跳转到编辑心情界面
- (void)editMoodWithModel{
    
    UIViewController *writeVC = [[CTMediator sharedInstance] CTMediator_WriteMoodDiaryViewController:@{@"editMood":self.dataArray}];
    [self presentViewController:writeVC animated:YES completion:nil];
}

#pragma mark - 删除心情
- (void)deleteMoodAction{
    
    LYMoodDiaryModel *model = (LYMoodDiaryModel *)self.dataArray[0];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:LY_LocalizedString(@"kLYDeleteMoodAlertTitle") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:LY_LocalizedString(@"kLYSheetCancel") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:LY_LocalizedString(@"kLYButtonEnsureTitle") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //删除
        if ([LYMoodDiaryDBManager deleteMoodDiaryWithModel:model]) {
            
            [self backButtonAction];
            [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYMoodDeleteSuccess") delay:1.f];
        }
    }];
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil] ;
}


#pragma mark - lazy loading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
