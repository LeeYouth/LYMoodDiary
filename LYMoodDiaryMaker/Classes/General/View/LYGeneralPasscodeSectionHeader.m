//
//  LYGeneralPasscodeSectionHeader.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGeneralPasscodeSectionHeader.h"

@interface LYGeneralPasscodeSectionHeader ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation LYGeneralPasscodeSectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    
    CGFloat leftM = kLYContentLeftMargin - 2;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(leftM);
        make.left.equalTo(self.mas_left).offset(leftM);
        make.right.equalTo(self.mas_right).offset(-leftM);
        make.height.mas_equalTo(@30);
    }];

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(kLYContentLeftMargin);
        make.right.equalTo(self.mas_right).offset(-kLYContentLeftMargin);
    }];
    
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text  = title;
    
    if (!title.length) {
        [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(-20);
            make.left.equalTo(self.mas_left).offset(kLYContentLeftMargin);
            make.right.equalTo(self.mas_right).offset(-kLYContentLeftMargin);
        }];
    }
    
}

- (void)setDetailTitle:(NSString *)detailTitle{
    _detailTitle = detailTitle;
    
    self.detailLabel.text = detailTitle;
}

#pragma mark - lazyloading
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont fontAliWithName:AlibabaPuHuiTiR size:18];
        view;
    }));
}
- (UILabel *)detailLabel{
    return LY_LAZY(_detailLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont fontAliWithName:AlibabaPuHuiTiL size:15];
        view.numberOfLines = 0;
        view;
    }));
}

@end

