//
//  LYHomepageGuideView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/5/21.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYHomepageGuideView.h"

@interface LYHomepageGuideView()

@property (nonatomic, strong) UIView      * menuBackView;
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UIButton    * okButton;
/** 类型 */
@property (nonatomic, copy) NSString *guideType;

@end

@implementation LYHomepageGuideView

- (instancetype)initWithGuideType:(NSString *)guideType{
    if ([super init]) {
        
        _guideType = guideType;
        [self setDefaultSettings];

    }
    return self;
}

- (void)setDefaultSettings{
    
    _menuBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _menuBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _menuBackView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
    [_menuBackView addGestureRecognizer: tap];
    self.alpha = 0;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.okButton];

    [self updateUI];
}

#pragma mark - privates
- (void)show{
    
    [LYMainWindow addSubview:_menuBackView];
    [LYMainWindow addSubview:self];
    
    __weak UIView *weakView = _menuBackView;
    self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
    [UIView animateWithDuration: 0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
        self.alpha = 1;
        weakView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss{

    __weak UIView *weakView = _menuBackView;
    __weak NSString *weakStr = _guideType;
    [UIView animateWithDuration: 0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
        self.alpha = 0;
        weakView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [weakView removeFromSuperview];
        
        //设置为已读
        [kUserDefault setBool:YES forKey:weakStr];
    }];
}

- (void)touchOutSide{
    [self dismiss];
}

- (void)tapClickAction{
    [self dismiss];
}

- (void)setShowMaskView:(BOOL)showMaskView{
    _showMaskView = showMaskView;
   
    _menuBackView.backgroundColor = showMaskView ? [[UIColor blackColor] colorWithAlphaComponent:0.2] : [UIColor clearColor];
}

- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    [self updateUI];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self updateUI];
}

- (void)updateUI{

    CGFloat imageWidth  = 120;
    CGFloat leftMargin  = 35;
    CGFloat titleHeight = 0;
    CGFloat tempMargin  = 20;
    CGSize titleMaxSize  = CGSizeMake(kScreenWidth - 2*leftMargin, MAXFLOAT);
    CGSize btnSize      = CGSizeMake(kScreenWidth - 2*leftMargin, 44);

    if (self.title.length) {
        titleHeight = [self.title sizeForFont:[UIFont writeMoodFont] size:titleMaxSize mode:NSLineBreakByWordWrapping].height;
        self.titleLabel.text = self.title;
    }
    CGFloat height = tempMargin + imageWidth + tempMargin + titleHeight + tempMargin + btnSize.height + tempMargin;
    
    CGFloat y = kScreenHeight - height;
    self.frame = CGRectMake(0, y, kScreenWidth, height + kTabbarExtra);
    
    [self setNeedsDisplay];
}



- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
   
    CGFloat imageWidth  = 120;
    CGFloat leftMargin  = 35;
    CGFloat titleHeight = 0;
    CGFloat tempMargin  = 20;
    CGSize titleMaxSize = CGSizeMake(kScreenWidth - 2*leftMargin, MAXFLOAT);
    CGSize btnSize      = CGSizeMake(kScreenWidth - 2*leftMargin, 44);

    if (self.title.length) {
        titleHeight = [self.title sizeForFont:[UIFont writeMoodFont] size:titleMaxSize mode:NSLineBreakByWordWrapping].height;
        self.titleLabel.text = self.title;
    }
    
    self.iconImageView.frame = CGRectMake((kScreenWidth - imageWidth)/2, tempMargin, imageWidth, imageWidth);
    self.titleLabel.frame = CGRectMake(kLYContentLeftMargin, imageWidth + tempMargin, kScreenWidth - 2*kLYContentLeftMargin, titleHeight);
    self.okButton.frame = CGRectMake(leftMargin, self.titleLabel.bottom + tempMargin, btnSize.width, btnSize.height);

    self.titleLabel.text   = self.title;
    self.titleLabel.hidden = !self.title.length;
    self.iconImageView.image = self.iconImage;
    
}

#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
- (void)closeButtonAction{
    [self dismiss];
}

- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(@"444444");
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont writeMoodFont];
        view.numberOfLines = 0;
        view;
    }));
}
- (UIButton *)okButton{
    return LY_LAZY(_okButton, ({
        UIButton *view = [UIButton new];
        [view setBackgroundImage:[UIImage createImageWithColor:[UIColor themeButtonColor]] forState:UIControlStateNormal];
        [view setTitleColor:LYColor(LYWhiteColorHex) forState:UIControlStateNormal];
        [view setTitle:LY_LocalizedString(@"kLYHomePageGuideOK") forState:UIControlStateNormal];
        view.titleLabel.font = [UIFont writeMoodFont];
        [view addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        view.layer.cornerRadius = 4.f;
        view.layer.masksToBounds = YES;
        view;
    }));
}
@end

