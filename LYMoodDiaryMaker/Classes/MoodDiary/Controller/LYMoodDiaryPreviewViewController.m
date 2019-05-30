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

@end

@implementation LYMoodDiaryPreviewViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf);
    self.navBarView.leftBarItemImage  = [UIImage imageNamed:@"navBar_closeicon"];
    self.navBarView.navColor = [UIColor whiteColor];
    self.navBarView.rightBarItemImage = nil;
    self.navBarView.btnBlock = ^(UIButton *sender) {
        if (sender.tag == 0) {
            //返回
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
    
    self.tableView.backgroundColor = LYHomePageColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    LYBaseCustomTableHeaderView *headerView = [[LYBaseCustomTableHeaderView alloc] init];
    headerView.title       = LY_LocalizedString(@"kLYSheetPreview");
    headerView.detailTitle = [self.previewModel.enterDate stringWithFormat:kHEADERFULLDATEFORMAT];
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView reloadData];
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
    if (indexPath.row == 0) {
        LYMoodDiaryPreviewEmojiCell *cell = [LYMoodDiaryPreviewEmojiCell cellWithTableView:tableView];
        cell.model = self.previewModel;
        return cell;
    }
    LYMoodDiaryPreviewTextCell *cell = [LYMoodDiaryPreviewTextCell cellWithTableView:tableView];
    cell.model = self.previewModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - lazy loading

@end
