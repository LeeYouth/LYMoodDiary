//
//  LYMoodDiaryPreviewTextCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryPreviewTextCell.h"

@interface LYMoodDiaryPreviewTextCell()

@property (nonatomic, strong) YYTextView *textView;

@end

@implementation LYMoodDiaryPreviewTextCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYMoodDiaryPreviewTextCell";
    
    LYMoodDiaryPreviewTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYMoodDiaryPreviewTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
}

- (void)setModel:(LYMoodDiaryModel *)model{
    _model = model;
    
    
    CGSize size = CGSizeMake(kScreenWidth - 2*kLYContentLeftMargin, CGFLOAT_MAX);
    NSAttributedString *text = [[NSAttributedString alloc] initWithString: model.moodDiaryText attributes:@{NSFontAttributeName:HPL20,NSForegroundColorAttributeName:black_color}];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    
    self.height = layout.textBoundingSize.height + kLYContentLeftMargin;
    
    self.textView.attributedText = text;

}

#pragma mark - lazy
- (YYTextView *)textView{
    return LY_LAZY(_textView, ({
        YYTextView *view = [YYTextView new];
        view.textColor = black_color;
        view.font = HPL20;
        view.editable = NO;
        view.scrollEnabled = NO;
        view.textVerticalAlignment = YYTextVerticalAlignmentTop;
        view.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        view;
    }));
}
@end
