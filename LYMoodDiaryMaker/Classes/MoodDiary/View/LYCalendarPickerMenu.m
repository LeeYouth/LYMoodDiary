//
//  LYCalendarPickerMenu.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/16.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYCalendarPickerMenu.h"
#import "FSCalendar.h"

#define LYCalendarPickerTitleColor bgColor

#define LYCalendarPickerMenuButtonH 80.f
#define LYCalendarPickerMenuHeight (LYCalendarPickerMenuButtonH + kNavBarExtra + kLYCalendarHeight)


@interface LYCalendarPickerMenu()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (nonatomic, strong) UIView      * menuBackView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UIButton    * ensureButton;
@property (nonatomic, strong) FSCalendar  * calendar;
@property (nonatomic, strong) NSDate      * currentDate;
@property (nonatomic, strong) NSDate      * changeDate;
@property (nonatomic, strong) NSMutableArray      * allMoodDateArray;

@end

@implementation LYCalendarPickerMenu

- (instancetype)initRelyOnView:(UIView *)view{
    if ([super init]) {
        [self loadAllHasMoodDateData];
        [self setDefaultSettings];
    }
    return self;
}

- (void)setDefaultSettings{

    _menuBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _menuBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    _menuBackView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
    [_menuBackView addGestureRecognizer: tap];
    self.alpha = 0;
    self.backgroundColor = bgColor;
    self.frame = CGRectMake(0, 0, kScreenWidth, LYCalendarPickerMenuHeight);

    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //必须给frame因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.ensureButton];
    [self addSubview:self.calendar];
    
    CGFloat radii = 12.f;
    [self addRoundedCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) withRadii:CGSizeMake(radii, radii) viewRect:self.bounds];
    [effectView addRoundedCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) withRadii:CGSizeMake(radii, radii) viewRect:self.bounds];

    
    [self setNeedsDisplay];
}

- (void)loadAllHasMoodDateData{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM";
    NSString *findStr = [dateFormatter stringFromDate:self.changeDate];
    
    NSArray * resultArray = [LYMoodDiaryModel bg_find:kLYMOODTABLENAME type:bg_createTime dateTime:findStr];
    if (self.allMoodDateArray.count) {
        [self.allMoodDateArray removeAllObjects];
    }
    WEAKSELF(weakSelf);
    [resultArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LYMoodDiaryModel *model = (LYMoodDiaryModel *)obj;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSString *str = [dateFormatter stringFromDate:model.enterDate];
        if (![weakSelf.allMoodDateArray containsObject:str]) {
            [weakSelf.allMoodDateArray addObject:str];
        }
    }];
    [self.calendar reloadData];
    LYLog(@"----aaaa = %@",self.allMoodDateArray);
}

#pragma mark - privates
- (void)show{
    [LYMainWindow addSubview:_menuBackView];
    [LYMainWindow addSubview:self];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lyCalendarMenuBeganShow)]) {
        [self.delegate lyCalendarMenuBeganShow];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    self.transform = CGAffineTransformMakeTranslation(0, -LYCalendarPickerMenuHeight);
    __weak UIView *weakMenu = _menuBackView;
    [UIView animateWithDuration: 0.4 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
        self.alpha = 1;
        weakMenu.alpha = 1;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyCalendarMenuDidShow)]) {
            [self.delegate lyCalendarMenuDidShow];
        }

    }];
}

- (void)dismiss{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lyCalendarMenuBeganDismiss)]) {
        [self.delegate lyCalendarMenuBeganDismiss];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

    __weak UIView *weakMenu = _menuBackView;

    [UIView animateWithDuration: 0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -LYCalendarPickerMenuHeight);
        self.alpha = 0;
        weakMenu.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyCalendarMenuDidDismiss)]) {
            [self.delegate lyCalendarMenuDidDismiss];
        }
        [self removeFromSuperview];
        [weakMenu removeFromSuperview];
    }];
}

- (void)touchOutSide{
    [self dismiss];
}

- (void)closeButtonAction:(UIButton *)sender{

    if (self.didSelected) {
        self.didSelected(self.currentDate);
    }

    [self dismiss];
}

- (void)setShowMaskView:(BOOL)showMaskView{
    _showMaskView = showMaskView;
    _menuBackView.backgroundColor = showMaskView ? [[UIColor blackColor] colorWithAlphaComponent:0.1] : [UIColor clearColor];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    CGFloat btnW = [LY_LocalizedString(@"kLYButtonEnsureTitle") sizeForFont:HPR14 size:CGSizeMake(300, MAXFLOAT) mode:NSLineBreakByWordWrapping].width + 24;
        
    self.calendar.frame = CGRectMake(10, LYCalendarPickerMenuButtonH + kNavBarExtra, kScreenWidth - 20, kLYCalendarHeight);
    self.ensureButton.frame = CGRectMake(kScreenWidth - btnW - kLYContentLeftMargin, kNavBarExtra + 30, btnW, 24);
    self.titleLabel.frame = CGRectMake(kLYContentLeftMargin, kNavBarExtra + 30, kScreenWidth - btnW - kLYContentLeftMargin - 2*kLYContentLeftMargin, 30);
}

#pragma mark - FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.currentDate = date;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM";
    self.titleLabel.text = [dateFormatter stringFromDate:calendar.currentPage];
    self.changeDate = calendar.currentPage;
    [self loadAllHasMoodDateData];
}

#pragma mark - FSCalendarDataSource
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    return [NSDate date];
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *key = [dateFormatter stringFromDate:date];
    if ([self.allMoodDateArray containsObject:key]) {
        return 3;
    }
    return 0;
}

#pragma mark - <FSCalendarDelegateAppearance>
- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *key = [dateFormatter stringFromDate:date];
    if ([self.allMoodDateArray containsObject:key]) {
        return @[happyColor,inLoveColor,madColor];
    }
    return nil;
}

- (FSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,  0, kScreenWidth, kLYCalendarHeight)];
        _calendar.dataSource = self;
        _calendar.delegate   = self;
        _calendar.swipeToChooseGesture.enabled = YES;
        _calendar.allowsMultipleSelection = NO;
        
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = languages.firstObject;
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:systemLanguage];
        _calendar.firstWeekday = 2;
        _calendar.headerHeight = 0;
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;

        _calendar.appearance.headerTitleColor = LYCalendarPickerTitleColor;
        _calendar.appearance.headerTitleFont = HPR24;
        _calendar.appearance.weekdayTextColor = LYCalendarPickerTitleColor;
        _calendar.appearance.weekdayFont = HPB16;
        _calendar.appearance.titleDefaultColor = LYCalendarPickerTitleColor;
        _calendar.appearance.titleFont = HPL16;
        
        _calendar.appearance.todayColor = themeButtonColor;
        
        _calendar.appearance.headerDateFormat = @"yyyy/MM";
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;


        _calendar.calendarHeaderView.backgroundColor = [UIColor clearColor];
        _calendar.calendarWeekdayView.backgroundColor = [UIColor clearColor];
        _calendar.appearance.eventSelectionColor = LYCalendarPickerTitleColor;
        _calendar.appearance.eventOffset = CGPointMake(0, -7);
        _calendar.today = [NSDate date]; // Hide the today circle
        
    }
    return _calendar;
}

- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = HPR26;
        view.textColor = LYCalendarPickerTitleColor;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy/MM";
        view.text = [dateFormatter stringFromDate:[NSDate date]];
        view;
    }));
}
- (UIButton *)ensureButton{
    return LY_LAZY(_ensureButton, ({
        UIButton *view = [UIButton new];
        view.tag = 1;
        UIImage *image = [UIImage createImageWithColor:themeButtonColor rect:CGRectMake(0, 0, 44, 24)];
        [view setBackgroundImage:image forState:UIControlStateNormal];
        [view setTitle:LY_LocalizedString(@"kLYButtonEnsureTitle") forState:UIControlStateNormal];
        [view setTitleColor:white_color forState:UIControlStateNormal];
        view.titleLabel.font = HPR14;
        [view addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        view.layer.cornerRadius = 4.f;
        view.layer.masksToBounds = YES;
        view;
    }));
}
- (NSDate *)currentDate{
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}
- (NSMutableArray *)allMoodDateArray{
    if (!_allMoodDateArray) {
        _allMoodDateArray = [NSMutableArray array];
    }
    return _allMoodDateArray;
}
- (NSDate *)changeDate{
    if (!_changeDate) {
        _changeDate = [NSDate date];
    }
    return _changeDate;
}
@end
