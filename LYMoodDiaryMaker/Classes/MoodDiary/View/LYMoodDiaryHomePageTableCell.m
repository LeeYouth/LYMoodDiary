//
//  LYMoodDiaryHomePageTableCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryHomePageTableCell.h"

@interface LYMoodDiaryHomePageTableCell()

@property (nonatomic, strong) UIView *iconBackView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *cardBackView;
@property (nonatomic, strong) YYLabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation LYMoodDiaryHomePageTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYMoodDiaryHomePageTableCell";
    
    LYMoodDiaryHomePageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYMoodDiaryHomePageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dk_backgroundColorPicker = bgColor;
        [self setUpSubViews];
    }
    return self;
}

+ (CGFloat)getCellHeight{
    CGFloat topMargin = 10;
    CGFloat iconW = 50;
    return 2*topMargin + iconW + 110;
}
- (void)setUpSubViews{
    [self addSubview:self.cardBackView];
    [self.cardBackView addSubview:self.contentLabel];
    [self.cardBackView addSubview:self.timeLabel];

    [self addSubview:self.iconBackView];
    [self addSubview:self.iconImageView];

    
    CGFloat topMargin = 10;
    CGFloat iconW = 50;
    CGFloat cardH = [LYMoodDiaryHomePageTableCell getCellHeight] - iconW/2 - 2*topMargin;
    CGFloat cardLeft = 20;
    CGFloat cardTop  = topMargin + iconW/2;
    CGFloat contentLeft  = 15;

    [self.cardBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(cardH));
        make.left.equalTo(self.mas_left).offset(cardLeft);
        make.right.equalTo(self.mas_right).offset(-cardLeft);
        make.top.equalTo(self.mas_top).offset(cardTop);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconW, iconW));
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.cardBackView.mas_left).offset(15);
    }];
    
    [self.iconBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.iconImageView);
        make.size.mas_equalTo(CGSizeMake(iconW + 4, iconW + 4));
    }];
    
    CGFloat timeW = [@" 23:59 " sizeWithAttributes:@{NSFontAttributeName:HPR16}].width;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImageView.mas_bottom).offset(5);
        make.right.equalTo(self.cardBackView.mas_right).offset(-contentLeft);
        make.size.mas_equalTo(CGSizeMake(timeW, 18));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.left.equalTo(self.cardBackView.mas_left).offset(contentLeft);
        make.right.equalTo(self.cardBackView.mas_right).offset(-contentLeft);
        make.bottom.equalTo(self.cardBackView.mas_bottom).offset(-contentLeft);
    }];
    


}

- (void)setModel:(LYMoodDiaryModel *)model{
    _model = model;
    
    self.timeLabel.text    = [model.enterDate stringWithFormat:kLISTCELLDATEFORMAT];
    self.contentLabel.text = model.moodDiaryText;
    self.cardBackView.dk_backgroundColorPicker = [LYMoodDiaryModel matchEmojiColorWithType:model.moodType];
    self.iconImageView.image = [UIImage imageWithEmojiType:model.typeName];
}

#pragma mark - 表情点击操作
- (void)tapClickAction{
    LYEmojiPopMenu *menu = [[LYEmojiPopMenu alloc] initRelyOnView:self.iconImageView Emojis:@[self.model.typeName]];
    menu.showMaskView = NO;
    [menu show];
}

#pragma - 长按手势
// 长按图片的时候就会触发长按手势
- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    // 一般开发中,长按操作只会做一次
    // 假设在一开始长按的时候就做一次操作
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        WEAKSELF(weakSelf);
        LYMoodDiaryModel *model = self.model;
        LYActionSheet *sheetView = [[LYActionSheet alloc] initWithSheetTitles:@[LY_LocalizedString(@"kLYSheetPreview"),LY_LocalizedString(@"kLYSheetDelete")]];
        sheetView.title = model.moodDiaryText;
        sheetView.didSelected = ^(NSInteger index) {
            if (weakSelf.didSelected) {
                weakSelf.didSelected(index);
            }
        };
        [sheetView show];
    }
}

#pragma mark - 双击文本
- (void)doubleTapGestureAction{
    if (self.didSelected) {
        self.didSelected(0);
    }
}
- (void)handleSingleTap{
    if (self.didSelected) {
        self.didSelected(10001);
    }
}

#pragma mark - 懒加载
- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        CGFloat iconW = 50;
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction)];
        [view addGestureRecognizer:tap];
        view;
    }));
}
- (UIView *)iconBackView{
    return LY_LAZY(_iconBackView, ({
        CGFloat iconW = 54;
        UIView *view = [UIView new];
        view.dk_backgroundColorPicker = bgColor;
        view.layer.cornerRadius = iconW/2;
        view.layer.masksToBounds = YES;
        view;
    }));
}
- (UIView *)cardBackView{
    return LY_LAZY(_cardBackView, ({
        UIView *view = [UIView new];
        view.layer.cornerRadius = 14.f;
        // 长按
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//        [view addGestureRecognizer:longPress];
//        
//        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap)];
//        singleTapGesture.numberOfTapsRequired     = 1;
//        singleTapGesture.numberOfTouchesRequired  = 1;
//        [view addGestureRecognizer:singleTapGesture];
//
//        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureAction)];
//        doubleTapGesture.numberOfTapsRequired    = 2;
//        doubleTapGesture.numberOfTouchesRequired = 1;
//        [view addGestureRecognizer:doubleTapGesture];
//        [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];

        view;
    }));
}
- (YYLabel *)contentLabel{
    return LY_LAZY(_contentLabel, ({
        YYLabel *view = [YYLabel new];
        DKColorPicker picker = moodCardColor;
        view.textColor = picker(self.dk_manager.themeVersion);
        view.font = HPR16;
        view.textVerticalAlignment = YYTextVerticalAlignmentTop;
        view.numberOfLines = 0;
        view;
    }));
}
- (UILabel *)timeLabel{
    return LY_LAZY(_timeLabel, ({
        UILabel *view = [UILabel new];
        view.dk_textColorPicker = moodCardColor;
        view.textAlignment = NSTextAlignmentRight;
        view.font = HPR16;
        view;
    }));
}
@end
