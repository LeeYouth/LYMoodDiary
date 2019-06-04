//
//  NSDate+LYFormatDate.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "NSDate+LYFormatDate.h"

@implementation NSDate (LYFormatDate)

/**
  *  是否为今年
  */
- (BOOL)isThisYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year;
}

- (NSString *)ENCurrentMonth{
    NSInteger month = [self month];
    //January 一月 Jan.
    //February 二月 Feb.
    //March 三月 Mar.
    //April 四月 Apr.
    //May 五月 May
    //June 六月 Jun.
    //July 七月 Jul.
    //August 八月 Aug.
    //September 九月 Sept.
    //October 十月 Oct.
    //November 十一月 Nov.
    //December 十二月 Dec.
    NSArray *titleArray = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    NSString *monthStr = @"";
    if (month > 0 && month <= 12) {
        monthStr = titleArray[month-1];
    }
    return monthStr;
}

- (NSString *)ENCutCurrentMonth{
    NSInteger month = [self month];
    //January 一月 Jan.
    //February 二月 Feb.
    //March 三月 Mar.
    //April 四月 Apr.
    //May 五月 May
    //June 六月 Jun.
    //July 七月 Jul.
    //August 八月 Aug.
    //September 九月 Sept.
    //October 十月 Oct.
    //November 十一月 Nov.
    //December 十二月 Dec.
    NSArray *titleArray = @[@"Jan.",@"Feb.",@"Mar.",@"Apr.",@"May",@"Jun.",@"Jul.",@"Aug.",@"Sept.",@"Oct.",@"Nov.",@"Dec."];
    NSString *monthStr = @"";
    if (month > 0 && month <= 12) {
        monthStr = titleArray[month-1];
    }
    return monthStr;
}


- (NSString *)ENCurrentDay{
    NSInteger day = [self day];
    if (day == 1 || day == 21 || day == 31) {
        return [NSString stringWithFormat:@"%@%@",@(day),@"st"];
    }else if (day == 2 || day == 22 ){
        return [NSString stringWithFormat:@"%@%@",@(day),@"nd"];
    }else if (day == 3 || day == 23 ){
        return [NSString stringWithFormat:@"%@%@",@(day),@"rd"];
    }else{
        return [NSString stringWithFormat:@"%@%@",@(day),@"th"];
    }
}

- (NSString *)CNCurrentMonth{
    NSInteger month = [self month];
    NSArray *titleArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];

    NSString *monthStr = @"";
    if (month > 0 && month <= 12) {
        monthStr = titleArray[month-1];
    }
    return monthStr;
}
- (NSString *)CNCurrentWeekday{
    NSArray *titleArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSInteger weekday = [self weekday];
    NSString *weekdayStr = @"";
    if (weekday >= 1 && weekday <= 7) {
        weekdayStr = titleArray[weekday-1];
    }
    return weekdayStr;
}



- (NSString *)navigationTitle{
    if ([NSBundle isChineseLanguage]) {
        return [self stringWithFormat:@"yyyy年MM月dd日"];
    }
    return [NSString stringWithFormat:@"%@ %@ %@",[self ENCutCurrentMonth],[self ENCurrentDay],[self stringWithFormat:@"yyyy"]];
}


- (NSString *)tableHeaderTitle{

    if ([self isThisYear]) {
        //今年（中：5月 英：May）
        if ([NSBundle isChineseLanguage]) {
            return [self CNCurrentMonth];
        }
        return [self ENCurrentMonth];
    }
    return [self stringWithFormat:kHEADERTITLEDATEFORMAT];
}

- (NSString *)tableHeaderDetailTitle{
    if ([self isThisYear]) {
        //今年（16）
        if ([NSBundle isChineseLanguage]) {
            return [NSString stringWithFormat:@"%@日 %@",[self stringWithFormat:@"d"],[self CNCurrentWeekday]];
        }else{
            return [self ENCurrentDay];
        }
    }else{
        if ([NSBundle isChineseLanguage]) {
            
            return [NSString stringWithFormat:@"%@ %@",[self stringWithFormat:@"MM月dd日"],[self CNCurrentWeekday]];
        }
        return [NSString stringWithFormat:@"%@ %@",[self ENCutCurrentMonth],[self ENCurrentDay]];
    }
    return [self stringWithFormat:kHEADERDETAILTITLEDATEFORMAT];
}
@end
