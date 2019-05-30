//
//  LYSettingTableViewCell.m
//  LYWeChatMaker
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
        self.backgroundColor = [UIColor whiteColor];
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
        make.size.mas_equalTo(CGSizeMake(24, 24));
        make.right.equalTo(self.mas_right).offset(-leftMargin);
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
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(@0.8);
    }];
    self.titleLabel.text  = @"去评分";
}

+ (CGFloat)getCellHeight{
    return 68;
}

- (void)setTypeName:(NSString *)typeName{
    _typeName = typeName;

    NSString *title = @"";
    if ([typeName isEqualToString:@"history"]) {
        
        title = LY_LocalizedString(@"kLYSettingCellHistory");
        
    }else if ([typeName isEqualToString:@"export"]){
        
        title = LY_LocalizedString(@"kLYSettingCellExport");
        
    }else if ([typeName isEqualToString:@"noviceManual"]){
        
        title = LY_LocalizedString(@"kLYSettingCellNovice");
        
    }else if ([typeName isEqualToString:@"star"]){
        
        title = LY_LocalizedString(@"kLYSettingCellRate");
        
    }else if ([typeName isEqualToString:@"protocol"]){
        
        title = LY_LocalizedString(@"kLYSettingCellPrivacy");
        
    }else if ([typeName isEqualToString:@"aboutUs"]){
        title = [NSString stringWithFormat: @"%@%@",LY_LocalizedString(@"kLYSettingCellAbout"),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    }else if ([typeName isEqualToString:@"version"]){
        title = [NSString stringWithFormat: @"%@ %@",LY_LocalizedString(@"kLYSettingCellVersion"),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    self.titleLabel.text  = title;
    
    if ([typeName isEqualToString:@"version"]){
        self.accessoryType = UITableViewCellAccessoryNone;
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

#pragma mark - lazyloading
- (UIView *)lineView{
    return LY_LAZY(_lineView, ({
        UIView *view = [UIView new];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}
- (UIImageView *)iconView{
    return LY_LAZY(_iconView, ({
        UIImageView *view = [UIImageView new];
        view.hidden = YES;
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont fontAliWithName:AlibabaPuHuiTiL size:18];
        view;
    }));
}
@end
