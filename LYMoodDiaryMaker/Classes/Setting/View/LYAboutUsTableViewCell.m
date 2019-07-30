//
//  LYAboutUsTableViewCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/20.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYAboutUsTableViewCell.h"

@interface LYAboutUsTableViewCell()

@property (nonatomic, strong) YYTextView *textView;

@end

@implementation LYAboutUsTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYAboutUsTableViewCell";
    
    LYAboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYAboutUsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
}

- (void)updateUI{
    CGFloat topMargin   = kLYContentLeftMargin;
    CGFloat leftMargin  = kLYContentLeftMargin;
    
    NSString *text = self.introStr;
    
    CGSize maxSize = CGSizeMake(kScreenWidth - 2*kLYContentLeftMargin, CGFLOAT_MAX);
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:HPL15,NSForegroundColorAttributeName:black_color}];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:attText];
    CGFloat textHeight = layout.textBoundingSize.height;
    
    self.height = topMargin + textHeight + topMargin;
    
    self.textView.frame = CGRectMake(leftMargin, topMargin, kScreenWidth - 2*leftMargin, textHeight);
    
    self.textView.attributedText = attText;

}

- (void)setIntroStr:(NSString *)introStr{
    _introStr = introStr;
    
    [self updateUI];
}



#pragma mark - lazy
- (YYTextView *)textView{
    return LY_LAZY(_textView, ({
        YYTextView *view = [YYTextView new];
        view.textColor = black_color;
        view.font = HPL15;
        view.editable = NO;
        view.scrollEnabled = NO;
        view.textVerticalAlignment = YYTextVerticalAlignmentTop;
        view.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        view.dataDetectorTypes = UIDataDetectorTypeLink;
        view;
    }));
}

@end

