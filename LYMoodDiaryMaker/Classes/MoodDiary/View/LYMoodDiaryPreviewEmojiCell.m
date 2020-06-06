//
//  LYMoodDiaryPreviewEmojiCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryPreviewEmojiCell.h"

@interface LYMoodDiaryPreviewEmojiCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *emojiImageView;

@end

@implementation LYMoodDiaryPreviewEmojiCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYMoodDiaryPreviewEmojiCell";
    
    LYMoodDiaryPreviewEmojiCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYMoodDiaryPreviewEmojiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

+ (CGFloat)getCellHeight{
    return  100;
}

- (void)setUpSubViews{
    
    [self.emojiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kLYContentLeftMargin);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kLYContentLeftMargin);
        make.left.equalTo(self.emojiImageView.mas_right).offset(16);
        make.top.equalTo(self.emojiImageView.mas_top).offset(4);
        make.height.mas_equalTo(@40);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        //        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(@40);
        make.centerY.equalTo(self.emojiImageView.mas_centerY);
    }];
    
    self.titleLabel.hidden = YES;
}

- (void)setModel:(LYMoodDiaryModel *)model{
    _model = model;
    self.emojiImageView.image = [UIImage imageWithEmojiType:model.typeName];
    self.detailLabel.text = [model.enterDate stringWithFormat:kLISTCELLDATEFORMAT];
}

#pragma mark - lazy
- (UIImageView *)emojiImageView{
    return LY_LAZY(_emojiImageView, ({
        UIImageView *view = [[UIImageView alloc] init];
        view.image = [UIImage imageWithEmojiType:LYEMOJI_HAPPY];
        [self addSubview:view];
        view;
    }));
}
#pragma mark - lazy
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = HPR24;
        view.dk_textColorPicker = emptyDataTitleColor;
        view.numberOfLines = 0;
        [self addSubview:view];
        view;
    }));
}

- (UILabel *)detailLabel{
    return LY_LAZY(_detailLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = HPL38;
        view.dk_textColorPicker = emptyDataDetailTitleColor;
        view.textAlignment = NSTextAlignmentRight;
        view.numberOfLines = 0;
        [self addSubview:view];
        view;
    }));
}

@end
