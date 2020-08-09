//
//  LYGeneralPasscodeCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYGeneralPasscodeCell.h"

@interface LYGeneralPasscodeCell()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *switchButton;

@end

@implementation LYGeneralPasscodeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYGeneralPasscodeCell";
    
    LYGeneralPasscodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYGeneralPasscodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self addSubview:self.switchButton];
    [self addSubview:self.lineView];
    
    CGFloat leftMargin = kLYContentLeftMargin;

    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(64, 44));
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.switchButton.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.top.bottom.equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(@(kLYCellLineHeight));
    }];
    
    self.height = 68;
    

}


- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    BOOL switchOn  = [LYPasscodeManager passcodeSwitchOn];
    BOOL touchidOn = [LYPasscodeManager touchIDSwitchOn];

    if (indexPath.section == 0) {
        self.switchButton.hidden = indexPath.row == 1;

        if (indexPath.row == 0){
            self.titleLabel.text = LY_LocalizedString(@"kLYSettingCellPasscode");
            self.accessoryType = UITableViewCellAccessoryNone;
            
            self.titleLabel.dk_textColorPicker = listTitleColor;

            self.switchButton.selected = switchOn;

        }else{
            self.titleLabel.text = LY_LocalizedString(@"kLYGeneralPasscodeChange");
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            self.titleLabel.dk_textColorPicker = switchOn?listTitleColor:listDetailColor;
        }
        
    }else{
        self.switchButton.hidden = NO;

        if ([LYTouchIDManager canUseTouchID]) {
            self.titleLabel.dk_textColorPicker = switchOn?listTitleColor:listDetailColor;
            self.switchButton.enabled = switchOn;
            
            self.switchButton.selected = touchidOn;

        }else{
            self.switchButton.enabled = NO;
            self.titleLabel.dk_textColorPicker = emptyDataTitleColor;
        }
        self.titleLabel.text = LY_LocalizedString(@"kLYGeneralPasscodeTouchID");
    }
}

- (void)switchButtonClick:(UIButton *)sender{
    
 
    if ([LYPasscodeManager hasSetPasscode]) {
        
        sender.selected = !sender.selected;
        
        if (self.indexPath.section == 0) {
            //密码开关
            [kUserDefault setBool:sender.selected forKey:kHASOPENPASSCODESWITCH];
            [kUserDefault synchronize];
        }else{
            //touch id开关
            [kUserDefault setBool:sender.selected forKey:kHASOPENPASSCODETOUCHID];
            [kUserDefault synchronize];
        }
       
        if (self.didSelect) {
            self.didSelect(10000);
        }
    }else{
        //第一次去设置密码
        if (self.didSelect) {
            self.didSelect(10001);
        }
    }
    
    
}

#pragma mark - lazyloading
- (UIView *)lineView{
    return LY_LAZY(_lineView, ({
        UIView *view = [UIView new];
        view.dk_backgroundColorPicker = sepLineColor;
        view;
    }));
}
- (UIButton *)switchButton{
    return LY_LAZY(_switchButton, ({
        UIButton *view = [UIButton new];
        [view setImage:[UIImage imageNamed:@"general_passcode_switchoff"] forState:UIControlStateNormal];
        [view setImage:[UIImage imageNamed:@"general_passcode_switchon"] forState:UIControlStateSelected];
        [view addTarget:self action:@selector(switchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        view.hidden = YES;
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

