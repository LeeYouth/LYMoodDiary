//
//  LYMoodDiaryHomePageHeaderView.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryHomePageHeaderView.h"

@interface LYMoodDiaryHomePageHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LYMoodDiaryHomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.bottom.equalTo(self);
        }];
        
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"Alibaba-PuHuiTi-Medium" ofType:@"otf"];
//        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"Alibaba-PuHuiTi-Bold" ofType:@"otf"];
//
//        NSString *name = [UIFont realFontNameWithFontPath:path];
//        LYLog(@"-----1 = %@",name);
//        LYLog(@"-----2 = %@", [UIFont realFontNameWithFontPath:path1]);

    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - lazy
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = FONT_ALiHuiPu_Regular(40);
        view.dk_textColorPicker = listTitleColor;
        view.textAlignment = NSTextAlignmentCenter;
        [self addSubview:view];
        view;
    }));
}


@end
