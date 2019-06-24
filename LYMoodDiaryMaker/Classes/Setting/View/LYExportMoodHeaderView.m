//
//  LYExportMoodHeaderView.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYExportMoodHeaderView.h"

@interface LYExportMoodHeaderView ()

@property (nonatomic, strong) UILabel *beginTitleLabel;
@property (nonatomic, strong) UILabel *beginDetailLabel;

@property (nonatomic, strong) UILabel *endTitleLabel;
@property (nonatomic, strong) UILabel *endDetailLabel;

@property (nonatomic, strong) UILabel *tempLabel;

@end

@implementation LYExportMoodHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LYColor(LYWhiteColorHex);
        [self _setupSubViews];
        
    }
    return self;
}

+ (CGFloat)getViewHeight{
    return 120;
}
- (void)_setupSubViews{
    [self addSubview:self.beginTitleLabel];
    [self addSubview:self.beginDetailLabel];
    [self addSubview:self.endTitleLabel];
    [self addSubview:self.endDetailLabel];
    [self addSubview:self.tempLabel];
    
    [self.beginTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kLYContentLeftMargin);
        make.top.equalTo(self.mas_top).offset(kLYContentLeftMargin);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(@40);
    }];
    
    [self.beginDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beginTitleLabel.mas_bottom).offset(15);
        make.left.right.equalTo(self.beginTitleLabel);
        make.height.mas_equalTo(@25);
    }];
    
    [self.endTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kLYContentLeftMargin);
        make.top.equalTo(self.mas_top).offset(kLYContentLeftMargin);
        make.left.equalTo(self.mas_centerX);
        make.height.mas_equalTo(@40);
    }];
    
    [self.endDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endTitleLabel.mas_bottom).offset(15);
        make.left.right.equalTo(self.endTitleLabel);
        make.height.mas_equalTo(@25);
    }];
    
    [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 25));
        make.centerX.centerY.equalTo(self);
    }];
    
}


- (void)setBeginDate:(NSDate *)beginDate{
    _beginDate = beginDate;
    if (beginDate) {
        self.beginDetailLabel.text = [beginDate stringWithFormat:kHEADERFULLDATEFORMAT];
    }else{
        self.beginDetailLabel.text = LY_LocalizedString(@"kLYExportTime");
    }
}

- (void)setEndDate:(NSDate *)endDate{
    _endDate = endDate;
    if (endDate) {
        self.endDetailLabel.text = [endDate stringWithFormat:kHEADERFULLDATEFORMAT];

    }else{
        self.endDetailLabel.text = LY_LocalizedString(@"kLYExportTime");
    }
}

#pragma - lazy
- (UILabel *)beginTitleLabel{
    return LY_LAZY(_beginTitleLabel, ({
        UILabel *view = [UILabel new];
        view.text = LY_LocalizedString(@"kLYExportBegin");
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont headerTitleFont];
        view;
    }));
}
- (UILabel *)beginDetailLabel{
    return LY_LAZY(_beginDetailLabel, ({
        UILabel *view = [UILabel new];
        view.text = LY_LocalizedString(@"kLYExportTime");
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont headerDetailFont];
        view;
    }));
}
- (UILabel *)endTitleLabel{
    return LY_LAZY(_endTitleLabel, ({
        UILabel *view = [UILabel new];
        view.text = LY_LocalizedString(@"kLYExportEnd");
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont headerTitleFont];
        view.textAlignment = NSTextAlignmentRight;
        view;
    }));
}
- (UILabel *)endDetailLabel{
    return LY_LAZY(_endDetailLabel, ({
        UILabel *view = [UILabel new];
        view.text = LY_LocalizedString(@"kLYExportTime");
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont headerDetailFont];
        view.textAlignment = NSTextAlignmentRight;
        view;
    }));
}

- (UILabel *)tempLabel{
    return LY_LAZY(_tempLabel, ({
        UILabel *view = [UILabel new];
        view.text = @"-";
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont headerTitleFont];
        view.textAlignment = NSTextAlignmentCenter;
        view;
    }));
}
@end
