//
//  LYExportMoodBottomView.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYExportMoodBottomView.h"

@interface LYExportMoodBottomView ()

@property (nonatomic, strong) UIButton *exportButton;

@end

@implementation LYExportMoodBottomView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -3);
        self.layer.shadowOpacity = 0.3;
        
        [self _setupSubViews];
        
    }
    return self;
}
- (void)_setupSubViews{
    [self addSubview:self.exportButton];
    [self.exportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, kLYContentLeftMargin, 10 + kTabbarExtra, kLYContentLeftMargin));
    }];
}

- (void)exportAction:(UIButton *)sender{
    if (self.didSelected) {
        self.didSelected(sender.tag);
    }
}

+ (CGFloat)getViewHeight{
    return 64 + kTabbarExtra;
}

- (UIButton *)exportButton{
    return LY_LAZY(_exportButton, ({
        UIButton *button = [UIButton new];
        button.tag = 0;
        button.layer.cornerRadius = 4;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = [UIFont fontAliWithName:AlibabaPuHuiTiL size:18.f];
        [button setTitleColor:LYColor(LYWhiteColorHex) forState:UIControlStateNormal];
        [button setTitle:LY_LocalizedString(@"kLYSettingCellExport") forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor themeButtonColor]];
        [button addTarget:self action:@selector(exportAction:) forControlEvents:UIControlEventTouchUpInside];
        button;
    }));
}

@end
