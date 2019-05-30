//
//  LYPrivacyAgreementTableViewCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/20.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYPrivacyAgreementTableViewCell.h"

@interface LYPrivacyAgreementTableViewCell()

@property (nonatomic, strong) YYTextView *textView;

@end

@implementation LYPrivacyAgreementTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYPrivacyAgreementTableViewCell";
    
    LYPrivacyAgreementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYPrivacyAgreementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

    CGFloat leftMargin  = kLYContentLeftMargin;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.bottom.equalTo(self.mas_bottom).offset(-leftMargin);
        make.top.equalTo(self.mas_top);
    }];
    
    
    NSString *text = LY_LocalizedString(@"kLYSettingPricacyText");
    
    CGSize size = CGSizeMake(kScreenWidth - 2*kLYContentLeftMargin, CGFLOAT_MAX);
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont aboutUsFont],NSForegroundColorAttributeName:LYColor(LYBlackColorHex)}];

    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attText];
    
    self.height = layout.textBoundingSize.height + kLYContentLeftMargin;
    
    self.textView.attributedText = attText;
}

#pragma mark - lazy
- (YYTextView *)textView{
    return LY_LAZY(_textView, ({
        YYTextView *view = [YYTextView new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont aboutUsFont];
        view.editable = NO;
        view.scrollEnabled = NO;
        view.textVerticalAlignment = YYTextVerticalAlignmentTop;
        view.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        view.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        view;
    }));
}
@end
