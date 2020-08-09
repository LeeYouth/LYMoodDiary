//
//  LYSettingTableViewCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/7.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYSettingTableViewCell.h"

@interface LYSettingTableViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LYSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYSettingTableViewCell";
    
    LYSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dk_backgroundColorPicker = bgColor;
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    
    CGFloat leftMargin = kLYContentLeftMargin;
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.iconView.mas_left).offset(-leftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.top.bottom.equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@(kLYCellLineHeight));
    }];
    self.titleLabel.text  = @"去评分";
}

+ (CGFloat)getCellHeight{
    return 68;
}

- (void)setTypeName:(NSString *)typeName{
    _typeName = typeName;

    
    NSString *title = @"";
    if ([typeName isEqualToString:@"language"]) {
        
        title = LY_LocalizedString(@"kLYSettingCellLanguage");
        
    }else if ([typeName isEqualToString:@"search"]){
        
        title = LY_LocalizedString(@"kLYSettingCellSearch");
        
    }else if ([typeName isEqualToString:@"history"]) {
        
        title = LY_LocalizedString(@"kLYSettingCellHistory");
        
    }else if ([typeName isEqualToString:@"export"]){
        
        title = LY_LocalizedString(@"kLYSettingCellExport");
        
    }else if ([typeName isEqualToString:@"passcode"]){
        
        title = LY_LocalizedString(@"kLYSettingCellPasscode");
        
    }else if ([typeName isEqualToString:@"noviceManual"]){
        
        title = LY_LocalizedString(@"kLYSettingCellNovice");
        
    }else if ([typeName isEqualToString:@"aboutUs"]){
        
        title = LY_LocalizedString(@"kLYSettingCellAbout");
    }
    
    else if ([typeName isEqualToString:@"support"]){
        
        title = LY_LocalizedString(@"kLYSettingCellSupport");
        
    }else if ([typeName isEqualToString:@"star"]){
        
        title = LY_LocalizedString(@"kLYSettingCellRate");
        
    }else if ([typeName isEqualToString:@"protocol"]){
        
        title = LY_LocalizedString(@"kLYSettingCellPrivacy");
        
    }else if ([typeName isEqualToString:@"version"]){
        title = [NSString stringWithFormat: @"%@ %@",LY_LocalizedString(@"kLYSettingCellVersion"),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }else if ([typeName isEqualToString:@"darkModel"]){
        
        title = LY_LocalizedString(@"kLYSettingCellDarkModel");
        
    }
    self.titleLabel.text  = title;
    
    if ([typeName isEqualToString:@"version"]){
        self.iconView.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryNone;
    }else{
        self.iconView.hidden = NO;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
- (UIImageView *)iconView{
    return LY_LAZY(_iconView, ({
        UIImageView *view = [UIImageView new];
        view.dk_imagePicker = DKImagePickerWithNames(@"homePage_cellRightindicator",@"homePage_cellRightindicator-dark");
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
