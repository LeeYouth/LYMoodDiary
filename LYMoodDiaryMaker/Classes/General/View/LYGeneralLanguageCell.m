//
//  LYGeneralLanguageCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/4.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGeneralLanguageCell.h"

@interface LYGeneralLanguageCell()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation LYGeneralLanguageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYGeneralLanguageCell";
    
    LYGeneralLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYGeneralLanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dk_backgroundColorPicker = bgColor;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.checkButton];
    [self addSubview:self.lineView];
    
    CGFloat leftMargin = kLYContentLeftMargin;
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.checkButton.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.top.bottom.equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@0.8);
    }];
    
    self.height = 68;
    
    
}

- (void)setTypeName:(NSString *)typeName{
    _typeName = typeName;
    
    
//  @[@"zh-Hans",@"en",@"ja",@"fr",@"ko"];
    
    if ([typeName isEqualToString:@"defult"]) {
        self.titleLabel.text = LY_LocalizedString(@"kLYGeneralLanguageDefult");
    }else if([typeName isEqualToString:@"zh-Hans"]){
        self.titleLabel.text = LY_LocalizedString(@"kLYGeneralLanguageChina");
    }else if([typeName isEqualToString:@"en"]){
        self.titleLabel.text = LY_LocalizedString(@"kLYGeneralLanguageEnglish");
    }else if([typeName isEqualToString:@"ja"]){
        self.titleLabel.text = LY_LocalizedString(@"kLYGeneralLanguageJapan");
    }else if([typeName isEqualToString:@"fr"]){
        self.titleLabel.text = LY_LocalizedString(@"kLYGeneralLanguageFrench");
    }else if([typeName isEqualToString:@"ko"]){
        self.titleLabel.text = LY_LocalizedString(@"kLYGeneralLanguageKorean");
    }
    
}
- (void)setIsCheck:(BOOL)isCheck{
    _isCheck = isCheck;
    
    self.checkButton.hidden = !isCheck;
}


- (void)checkButtonClick:(UIButton *)sender{
    
    
}

#pragma mark - lazyloading
- (UIView *)lineView{
    return LY_LAZY(_lineView, ({
        UIView *view = [UIView new];
        view.dk_backgroundColorPicker = sepLineColor;
        view;
    }));
}
- (UIButton *)checkButton{
    return LY_LAZY(_checkButton, ({
        UIButton *view = [UIButton new];
        [view setImage:[UIImage imageNamed:@"general_language_check"] forState:UIControlStateNormal];
        [view addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.dk_textColorPicker = listTitleColor;
        view.font = HPL18;
        view;
    }));
}

@end

