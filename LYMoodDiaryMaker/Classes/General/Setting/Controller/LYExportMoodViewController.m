//
//  LYExportMoodViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYExportMoodViewController.h"
#import "FSCalendar.h"
#import "LYDIYCalendarCell.h"
#import "LYExportMoodHeaderView.h"
#import "LYExportMoodBottomView.h"
#import "LYCSVWriter.h"

@interface LYExportMoodViewController()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance,UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) LYExportMoodHeaderView *headerView;
@property (nonatomic, strong) LYExportMoodBottomView *bottomView;

@property (nonatomic, strong) NSMutableArray *allMoodDateArray;
@property (nonatomic, strong) NSCalendar *gregorian;


@property(nonatomic, strong) NSDate *BeginDate;
@property(nonatomic, strong) NSDate *EndDate;
@property(nonatomic, assign) BOOL SelectAction;

@end

@implementation LYExportMoodViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf);
    self.navBarView.leftBarItemImage  = [UIImage imageNamed:@"navBar_closeicon"];
    self.navBarView.navColor = bgColor;
    self.navBarView.rightBarItemImage = nil;
    self.navBarView.btnBlock = ^(UIButton *sender) {
        if (sender.tag == 0) {
            //返回
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

    [self.view addSubview:self.calendar];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.bottomView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(NAVBAR_HEIGHT));
        make.height.mas_equalTo(@([LYExportMoodHeaderView getViewHeight]));
        make.left.right.equalTo(self.view);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@([LYExportMoodBottomView getViewHeight]));
        make.bottom.left.right.equalTo(self.view);
    }];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    //加载所有数据
    [self loadAllHasMoodDateData];
}

#pragma mark - 加载所有数据
- (void)loadAllHasMoodDateData{
    if (self.allMoodDateArray.count) {
        [self.allMoodDateArray removeAllObjects];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        NSArray *resultArray = [LYMoodDiaryModel bg_findAll:kLYMOODTABLENAME];

        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
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
        });
        
    });
    
    
   
}


#pragma mark - 导出操作
- (void)exportAction{
    
    NSArray *selectArrray = [self.calendar selectedDates];
    if (selectArrray.count < 2) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYExportErrorDate") delay:1.f];
        return ;
    }
    
    [LYToastTool showLoadingWithStatus:@""];
    __block NSMutableArray *resultArray = [NSMutableArray array];
    [selectArrray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *array = [LYMoodDiaryModel bg_find:kLYMOODTABLENAME type:bg_updateTime dateTime:[(NSDate *)obj stringWithFormat:kSEARCHDATEFORMAT]];
        if (array.count) {
            [resultArray addObjectsFromArray:array];
        }
        if ([[selectArrray lastObject] isEqual:obj]) {
            [LYToastTool dismiss];
        }
    }];

    if (!resultArray.count) {
        [LYToastTool bottomShowWithText:LY_LocalizedString(@"kLYExportEmptyData") delay:1.f];
    }else{
    
        NSArray *urls = @[[NSURL fileURLWithPath:[LYCSVWriter exportCSVWithMoods:resultArray]]];
    
        UIActivityViewController *activituVC=[[UIActivityViewController alloc]initWithActivityItems:urls applicationActivities:nil];
        NSArray *cludeActivitys=@[
                                  UIActivityTypePostToVimeo,
                                  UIActivityTypeMessage,
                                  UIActivityTypeMail,
                                  UIActivityTypeCopyToPasteboard,
                                  UIActivityTypePrint,
                                  UIActivityTypeAssignToContact,
                                  UIActivityTypeSaveToCameraRoll,
                                  UIActivityTypeAddToReadingList,
                                  UIActivityTypePostToFlickr,
                                  UIActivityTypePostToTencentWeibo];
        activituVC.excludedActivityTypes = cludeActivitys;
        //显示分享窗口
        [self presentViewController:activituVC animated:YES completion:nil];
    }
}

#pragma mark - FSCalendarDelegate
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar{
}

#pragma mark - FSCalendarDataSource
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter dateFromString:@"1990-01-01"];
}
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    return [NSDate date];
}


#pragma mark - <FSCalendarDelegateAppearance>
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *key = [dateFormatter stringFromDate:date];
    if ([self.allMoodDateArray containsObject:key]) {
        return 3;
    }
    return 0;
}

- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *key = [dateFormatter stringFromDate:date];
    if ([self.allMoodDateArray containsObject:key]) {
        return @[happyColor,inLoveColor,madColor];
    }
    return nil;
}


#pragma mark - FSCalendarDataSource
- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    LYDIYCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];

}

#pragma mark - FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{

    if (!self.SelectAction){
        NSArray *selectArrray = [calendar selectedDates];
//        for (NSDate *select in selectArrray) {
//            [calendar deselectDate:select];
//        }
        [selectArrray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [calendar deselectDate:(NSDate *)obj];
        }];
        [_calendar selectDate:date];
        self.SelectAction = YES;
        self.BeginDate    = date;
        self.EndDate      = nil;
        [_calendar reloadData];
    }else{
        NSInteger number = [self numberOfDaysWithFromDate:self.BeginDate toDate:date];
        //选择相差为负数
        if (number < 0) {
            self.SelectAction = YES;
            [calendar deselectDate:self.BeginDate];
            [calendar selectDate:date];
            self.BeginDate    = date;
            self.EndDate      = nil;
            [_calendar reloadData];
        }else{
            self.SelectAction = NO;
            self.EndDate      = date;
            for (int i = 0; i<number; i++){
                [_calendar selectDate:[date dateByAddingTimeInterval:-i*60*60*24]];
            }
            [_calendar reloadData];
        }
        
    }
    self.headerView.beginDate = self.BeginDate;
    self.headerView.endDate   = self.EndDate;
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
//    [self configureVisibleCells];
    NSArray *selectArrray = [calendar selectedDates];
    [selectArrray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [calendar deselectDate:(NSDate *)obj];
    }];
    [_calendar selectDate:date];
    self.SelectAction = YES;
    self.BeginDate    = date;
    self.EndDate      = nil;
    [_calendar reloadData];
    self.headerView.beginDate = self.BeginDate;
    self.headerView.endDate   = self.EndDate;
}

#pragma mark - Private methods
- (void)configureVisibleCells{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    
    LYDIYCalendarCell *diyCell = (LYDIYCalendarCell *)cell;
    
    // Configure selection layer
    if (monthPosition == FSCalendarMonthPositionCurrent) {
        
        SelectionType selectionType = SelectionTypeNone;
        if ([self.calendar.selectedDates containsObject:date]) {
            NSDate *previousDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:date options:0];
            NSDate *nextDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:date options:0];
            if ([self.calendar.selectedDates containsObject:date]) {
                if ([self.calendar.selectedDates containsObject:previousDate] && [self.calendar.selectedDates containsObject:nextDate]) {
                    selectionType = SelectionTypeMiddle;
                } else if ([self.calendar.selectedDates containsObject:previousDate] && [self.calendar.selectedDates containsObject:date]) {
                    selectionType = SelectionTypeRightBorder;
                } else if ([self.calendar.selectedDates containsObject:nextDate]) {
                    selectionType = SelectionTypeLeftBorder;
                } else {
                    selectionType = SelectionTypeSingle;
                }
            }
        } else {
            selectionType = SelectionTypeNone;
        }
        
        if (selectionType == SelectionTypeNone) {
            diyCell.selectionLayer.hidden = YES;
            return;
        }
        
        diyCell.selectionLayer.hidden = NO;
        diyCell.selectionType = selectionType;
        
    } else {
        
        diyCell.selectionLayer.hidden = YES;
        
    }
}

-(NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comp = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];
    return comp.day;
}

- (FSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,  0, kScreenWidth, kScreenHeight  )];
        _calendar.backgroundColor = [UIColor whiteColor];

        _calendar.dataSource = self;
        _calendar.delegate   = self;
        _calendar.pagingEnabled = NO; // important
        _calendar.swipeToChooseGesture.enabled = YES;
        _calendar.allowsMultipleSelection = YES;
        _calendar.swipeToChooseGesture.enabled = YES;
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = languages.firstObject;
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:systemLanguage];
        _calendar.firstWeekday = 2;
        _calendar.headerHeight = 56;
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        _calendar.calendarHeaderView.backgroundColor = bgColor;

        _calendar.appearance.headerTitleColor = black_color;
        _calendar.appearance.headerTitleFont = HPR24;
        _calendar.appearance.weekdayTextColor = black_color;
        _calendar.appearance.weekdayFont = HPR16;
//        _calendar.appearance.titleDefaultColor = [UIColor whiteColor];
        _calendar.appearance.titleFont = HPL16;
        
//        _calendar.appearance.separators = FSCalendarSeparatorNone;
        _calendar.calendarHeaderView.clipsToBounds = YES;
        
        _calendar.appearance.headerDateFormat = @"yyyy/MM";
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
        
        
        _calendar.calendarHeaderView.backgroundColor = [UIColor clearColor];
        _calendar.calendarWeekdayView.backgroundColor = [UIColor clearColor];
        _calendar.appearance.eventSelectionColor = black_color;
        _calendar.appearance.eventOffset = CGPointMake(0, -7);
        _calendar.today = nil; // Hide the today circle
        [_calendar registerClass:[LYDIYCalendarCell class] forCellReuseIdentifier:@"cell"];


    }
    return _calendar;
}
- (NSMutableArray *)allMoodDateArray{
    if (!_allMoodDateArray) {
        _allMoodDateArray = [NSMutableArray array];
    }
    return _allMoodDateArray;
}
- (LYExportMoodHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LYExportMoodHeaderView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, kScreenWidth, 100)];
    }
    return _headerView;
}
- (LYExportMoodBottomView *)bottomView{
    if (!_bottomView) {
        WEAKSELF(weakSelf);
        _bottomView = [[LYExportMoodBottomView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, kScreenWidth, 60)];
        _bottomView.didSelected = ^(NSInteger index) {
            [weakSelf exportAction];
        };
    }
    return _bottomView;
}
@end
