//
//  LYNoviceManualTableViewCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/8.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYNoviceManualTableViewCell.h"

@interface LYNoviceManualTableViewCell()

@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation LYNoviceManualTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYNoviceManualTableViewCell";
    
    LYNoviceManualTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYNoviceManualTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    [self addSubview:self.textView];
    [self addSubview:self.leftImageView];
    [self addSubview:self.rightImageView];

}

- (void)updateUI{
    CGFloat topMargin   = kLYContentLeftMargin;
    CGFloat leftMargin  = kLYContentLeftMargin;
    CGFloat tempMargin  = 10;

    NSString *text = self.introStr;
    
    CGSize maxSize = CGSizeMake(kScreenWidth - 2*kLYContentLeftMargin, CGFLOAT_MAX);
    CGSize iconSize = CGSizeMake((maxSize.width - 10)/2, 320);
    
    DKColorPicker picker = listTitleColor;

    NSAttributedString *attText = [[NSAttributedString alloc] initWithString: text attributes:@{NSFontAttributeName:HPL15,NSForegroundColorAttributeName:picker(self.dk_manager.themeVersion)}];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:attText];
    CGFloat textHeight = layout.textBoundingSize.height;
    
    self.height = topMargin + textHeight + tempMargin + iconSize.height;
    
    self.textView.attributedText = attText;
    self.textView.frame = CGRectMake(leftMargin, topMargin, kScreenWidth - 2*leftMargin, textHeight);
    self.leftImageView.frame = CGRectMake(leftMargin, topMargin + textHeight, iconSize.width, iconSize.height);
    self.rightImageView.frame = CGRectMake(kScreenWidth/2 + 5, topMargin + textHeight, iconSize.width, iconSize.height);

}

- (void)setIntroStr:(NSString *)introStr{
    _introStr = introStr;
    
    [self updateUI];
}
- (void)setType:(NSInteger)type{
    _type = type;
    if (type == 0) {
        self.leftImageView.image = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYResources.bundle",@"setting_howtouse_1")];
        self.rightImageView.image = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYResources.bundle",@"setting_howtouse_2")];
    }else{
        self.leftImageView.image = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYResources.bundle",@"setting_howtouse_3")];
        self.rightImageView.image = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYResources.bundle",@"setting_howtouse_4")];
    }
}

#pragma mark - lazy
- (YYTextView *)textView{
    return LY_LAZY(_textView, ({
        YYTextView *view = [YYTextView new];
        DKColorPicker picker = listTitleColor;
        view.textColor = picker(self.dk_manager.themeVersion);
        view.font = HPL15;
        view.editable = NO;
        view.scrollEnabled = NO;
        view.textVerticalAlignment = YYTextVerticalAlignmentTop;
        view.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        view;
    }));
}

- (UIImageView *)leftImageView{
    return LY_LAZY(_leftImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
- (UIImageView *)rightImageView{
    return LY_LAZY(_rightImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
@end
