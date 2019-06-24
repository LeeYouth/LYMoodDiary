//
//  LYBaseCustomTableHeaderView.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/13.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYBaseCustomTableHeaderView.h"

@interface LYBaseCustomTableHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation LYBaseCustomTableHeaderView

@synthesize title = _title;
@synthesize detailTitle = _detailTitle;


- (instancetype)init{
    if ([super init]) {
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = LYColor(LYWhiteColorHex);
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        
        [self updateUI];
    }
    return self;
}


- (void)setTitle:(NSString *)title{
    _title = title;
    [self updateUI];
}

- (void)setDetailTitle:(NSString *)detailTitle{
    _detailTitle = detailTitle;
    [self updateUI];
}

- (void)updateUI{
    CGFloat leftMargin = kLYContentLeftMargin - 4;
    CGFloat leftMargin1 = kLYContentLeftMargin;
    CGFloat topMargin  = 15;
    CGFloat tempMargin = 10;
    CGFloat titleH = 0;
    CGFloat detailH = 0;
    
    CGFloat view1H = 0;
    CGFloat view2H = 0;
    
    CGSize titleMaxSize  = CGSizeMake(kScreenWidth - 2*leftMargin, MAXFLOAT);
    CGSize detailMaxSize = CGSizeMake(kScreenWidth - 2*leftMargin1, MAXFLOAT);

    if (self.title.length) {
        titleH = [self.title sizeForFont:[UIFont headerTitleFont] size:titleMaxSize mode:NSLineBreakByWordWrapping].height;
        
        view1H = titleH + topMargin;
        self.titleLabel.text = self.title;
    }
    
    if (self.detailTitle.length) {
        detailH = [self.detailTitle sizeForFont:[UIFont headerDetailFont] size:detailMaxSize mode:NSLineBreakByWordWrapping].height;
        view2H = detailH + tempMargin;
        self.detailLabel.text = self.detailTitle;
    }
    
    CGFloat bottomH = 15;
    if (self.title.length && self.detailTitle.length) {
        bottomH = 15;
    }
    

    self.titleLabel.hidden  = !self.title.length;
    self.detailLabel.hidden = !self.detailTitle.length;
    
    self.frame = CGRectMake(0, 0, kScreenWidth, view1H + view2H + bottomH);
    
    [self setNeedsDisplay];
    
    self.titleLabel.frame  = CGRectMake(leftMargin, topMargin, titleMaxSize.width, titleH);
    self.detailLabel.frame = CGRectMake(leftMargin1, view1H + tempMargin, detailMaxSize.width, detailH);
}

#pragma mark - lazy
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font =  [UIFont headerTitleFont];
        view.textColor = [UIColor tableHeaderTitleColor];
        view.numberOfLines = 0;
        view.hidden = YES;
        view;
    }));
}

- (UILabel *)detailLabel{
    return LY_LAZY(_detailLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = [UIFont headerDetailFont];
        view.textColor = [UIColor tableHeaderTitleColor];
        view.numberOfLines = 0;
        view.hidden = YES;
        view;
    }));
}

@end

