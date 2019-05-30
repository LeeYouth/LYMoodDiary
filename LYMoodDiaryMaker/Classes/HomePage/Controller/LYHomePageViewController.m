//
//  LYHomePageViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageViewController.h"
#import "LYMoodDiaryHomePageController.h"
#import "LYCalendarMoodViewController.h"

@interface LYHomePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView                   *scrollView;
@property (nonatomic, strong) LYMoodDiaryHomePageController  *yesterdayVC;
@property (nonatomic, strong) LYMoodDiaryHomePageController  *todayVC;
@property (nonatomic, strong) LYWriteMoodDiaryViewController  *writeVC;
@property (nonatomic, strong) NSArray                        *childVCs;

@end

@implementation LYHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![kUserDefault boolForKey:kHOMEPAGEGUIDEINDENTIFER]) {
        LYHomepageGuideView *guidView = [[LYHomepageGuideView alloc] initWithGuideType:kHOMEPAGEGUIDEINDENTIFER];
        guidView.title = LY_LocalizedString(@"kLYHomePageGuideTitle");
        guidView.iconImage = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYResources.bundle", @"homepage_guide_icon")];
        [guidView show];
    }
    
    

    self.navBarView.leftBarItemImage = nil;
    self.navBarView.navColor = [UIColor whiteColor];
    self.navBarView.hidden   = YES;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = self.view.bounds;
    
//    self.childVCs = @[self.yesterdayVC,self.todayVC];
    self.childVCs = @[self.yesterdayVC,self.todayVC,self.writeVC];

    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    [self.childVCs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        
        vc.view.frame = CGRectMake(idx * w, 0, w, h);
    }];
    self.scrollView.contentSize = CGSizeMake(self.childVCs.count * w, 0);
    // 默认显示播放器页
    self.scrollView.contentOffset = CGPointMake(w, 0);
}


- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat offsetY = scrollView.contentOffset.x;
//    CGFloat newoffsetY = offsetY + kScreenWidth/3;
//    if (newoffsetY > 20 && offsetY < 0 ){
//        //展示日历选择
//        [self.navigationController pushViewController:[[LYCalendarMoodViewController alloc] init] animated:YES];
//        return;
//    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = scrollView.contentOffset.x;
    CGFloat newoffsetY = offsetY + kScreenWidth/3;
    if (newoffsetY > 0 && offsetY < 0 ){
        //展示日历选择
        [self.navigationController pushViewController:[[LYCalendarMoodViewController alloc] init] animated:YES];
        return;
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x/scrollView.width;
    if (index == 2) {
        [self.writeVC textViewBecomeFirstResponder];
    }else{
        [self.writeVC textViewResignFirstResponder];
    }
    self.scrollView.bounces = index <= 0;
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO; // 禁止弹簧效果
        _scrollView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _scrollView;
}

- (LYMoodDiaryHomePageController *)yesterdayVC {
    if (!_yesterdayVC) {
        _yesterdayVC = [LYMoodDiaryHomePageController new];
        _yesterdayVC.yesterday = YES;
    }
    return _yesterdayVC;
}
- (LYMoodDiaryHomePageController *)todayVC {
    if (!_todayVC) {
        WEAKSELF(weakSelf);
        _todayVC = [LYMoodDiaryHomePageController new];
        _todayVC.itemClick = ^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(2*kScreenWidth, 0) animated:YES];
            [weakSelf.writeVC textViewBecomeFirstResponder];
        };
        _todayVC.yesterday = NO;
    }
    return _todayVC;
}
- (LYWriteMoodDiaryViewController *)writeVC {
    if (!_writeVC) {
        WEAKSELF(weakSelf);

        _writeVC = [LYWriteMoodDiaryViewController new];
        _writeVC.itemBlock = ^(NSInteger index) {
            if (index == 0) {
                //返回
                [weakSelf.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];

            }else if (index == 1){
                //保存
                [weakSelf.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
                [weakSelf.todayVC reloadTableData];
            }
        };

    }
    return _writeVC;
}

@end
