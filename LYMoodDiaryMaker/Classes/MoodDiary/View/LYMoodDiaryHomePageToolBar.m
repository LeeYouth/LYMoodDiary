//
//  LYMoodDiaryHomePageToolBar.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/14.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryHomePageToolBar.h"

#define LYMoodDiaryHomePageToolBarBtnH 60.f

@interface LYMoodDiaryHomePageToolBar ()

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation LYMoodDiaryHomePageToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGFloat buttonW = LYMoodDiaryHomePageToolBarBtnH;
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(buttonW, buttonW));
            make.right.equalTo(self.mas_right).offset(-kLYContentLeftMargin);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}

#pragma mark - lazy
- (UIButton *)addButton{
    return LY_LAZY(_addButton, ({
        UIButton *view = [[UIButton alloc] init];
        view.backgroundColor = [UIColor redColor];
        view.layer.cornerRadius = LYMoodDiaryHomePageToolBarBtnH/2;
        [self addSubview:view];
        view;
    }));
}


@end

