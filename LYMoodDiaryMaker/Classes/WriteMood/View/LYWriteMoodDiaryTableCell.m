//
//  LYWriteMoodDiaryTableCell.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/13.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYWriteMoodDiaryTableCell.h"
#import "LYWriteMoodDiaryAddEmojiCell.h"

@interface LYWriteMoodDiaryTableCell()


@end

@implementation LYWriteMoodDiaryTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYWriteMoodDiaryTableCell";
    
    LYWriteMoodDiaryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYWriteMoodDiaryTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

    CGFloat leftMargin  = 20;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.bottom.equalTo(self.mas_bottom).offset(-leftMargin);
        make.top.equalTo(self.mas_top);
    }];
    
}

- (void)setModel:(LYMoodDiaryModel *)model{
    _model = model;
    
    self.textView.text = model.moodDiaryText;
}

#pragma mark - lazy
- (YYTextView *)textView{
    return LY_LAZY(_textView, ({
        YYTextView *view = [YYTextView new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = [UIFont writeMoodFont];
        view;
    }));
}
@end
