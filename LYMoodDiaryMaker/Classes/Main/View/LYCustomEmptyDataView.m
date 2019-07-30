//
//  LYCustomEmptyDataView.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/17.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYCustomEmptyDataView.h"

#define LYEmptyDataViewTitleFont  HPR25
#define LYEmptyDataViewDetailTitleFont HPL17
#define LYEmptyDataViewButtonFont HPR14

@interface LYCustomEmptyDataView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *clickButton;

@end

@implementation LYCustomEmptyDataView

- (instancetype)init{
    if ([super init]) {
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.clickButton];
        
        [self updateUI];
    }
    return self;
}


- (void)setTitle:(NSString *)title{
    _title = title;
    [self updateUI];
}

- (void)setDetailTitle:(NSString *)detailTitle{
    _detailTitle = detailTitle;
    [self updateUI];
}

- (void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    [self updateUI];
}

- (void)updateUI{
    
    CGFloat leftMargin = 15;
    CGFloat topMargin = 15;
    CGFloat titleH = 0;
    CGFloat detailH = 0;
    CGFloat buttonH = 0;
    CGFloat buttonW = 0;
    
    CGFloat view1H = 0;
    CGFloat view2H = 0;
    CGFloat view3H = 0;
    
    CGSize maxSize = CGSizeMake(kScreenWidth - 2*leftMargin, MAXFLOAT);
    
    if (self.title.length) {
        titleH = [self.title sizeForFont:LYEmptyDataViewTitleFont size:maxSize mode:NSLineBreakByWordWrapping].height;

        view1H = titleH + topMargin;
        self.titleLabel.text = self.title;
    }
    
    if (self.detailTitle.length) {
        detailH = [self.detailTitle sizeForFont:LYEmptyDataViewDetailTitleFont size:maxSize mode:NSLineBreakByWordWrapping].height;
        view2H = detailH + topMargin;
        self.detailLabel.text = self.detailTitle;
    }
    
    if (self.buttonTitle.length) {
        buttonH = 32.f;
        buttonW = [self.buttonTitle sizeForFont:LYEmptyDataViewDetailTitleFont size:maxSize mode:NSLineBreakByWordWrapping].width;

        view3H = buttonH + topMargin;
        [self.clickButton setTitle:self.buttonTitle forState:UIControlStateNormal];
    }
    self.titleLabel.hidden  = !self.title.length;
    self.detailLabel.hidden = !self.detailTitle.length;
    self.clickButton.hidden = !self.buttonTitle.length;
    
    self.frame = CGRectMake(0, 0, kScreenWidth, view1H + view2H + view3H);
    
    [self setNeedsDisplay];
    
    self.titleLabel.frame  = CGRectMake(leftMargin, 0, maxSize.width, titleH);
    self.detailLabel.frame = CGRectMake(leftMargin, view1H, maxSize.width, detailH);
    self.clickButton.frame = CGRectMake((kScreenWidth - buttonW)/2, view1H + view2H, buttonW + 20, buttonH);
}



- (void)closeButtonAction:(UIButton *)sender{
    if (self.didSelected) {
        self.didSelected(0);
    }
}

#pragma mark - lazy
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font =  LYEmptyDataViewTitleFont;
        view.textColor = emptyDataTitleColor;
        view.textAlignment = NSTextAlignmentCenter;
        view.numberOfLines = 0;
        view.hidden = YES;
        view;
    }));
}

- (UILabel *)detailLabel{
    return LY_LAZY(_detailLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = LYEmptyDataViewDetailTitleFont;
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = emptyDataDetailTitleColor;
        view.numberOfLines = 0;
        view.hidden = YES;
        view;
    }));
}
- (UIButton *)clickButton{
    return LY_LAZY(_clickButton, ({
        UIButton *view = [UIButton new];
        UIImage *image = [UIImage createImageWithColor:themeButtonColor];
        [view setBackgroundImage:image forState:UIControlStateNormal];
        [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        view.titleLabel.font = LYEmptyDataViewButtonFont;
        [view addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        view.layer.cornerRadius = 4.f;
        view.layer.masksToBounds = YES;
        view.hidden = YES;
        view;
    }));
}

@end

