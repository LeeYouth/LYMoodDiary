//
//  LYTouchIDDefultViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYTouchIDDefultViewController.h"

@interface LYTouchIDDefultViewController ()

@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation LYTouchIDDefultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navBarView.leftBarItemImage = nil;
    self.navBarView.rightBarItemImage = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backImageView];
    
    CGSize viewSize  = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = nil;
    NSArray *launchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.backImageView.image = [UIImage imageNamed:launchImage];
    
    
}

- (void)tapAction{
    [LYTouchIDManager initTouchIDWithMessage:@"" completion:^(BOOL prompted) {
        if (self.completion) {
            self.completion(prompted?1:0);
        }
    }];
}


- (UIImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        UIImageView *view = [[UIImageView alloc] init];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [view addGestureRecognizer:tap];
        view;
    }));
}

@end
