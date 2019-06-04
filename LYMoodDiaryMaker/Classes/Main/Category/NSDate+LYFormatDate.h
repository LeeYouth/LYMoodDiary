//
//  NSDate+LYFormatDate.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LYFormatDate)

/**
  *  是否为今年
  */
- (BOOL)isThisYear;

/**
  *  英文当前月（January ~ December）
  */
- (NSString *)ENCurrentMonth;

/**
  *  英文缩写当前月（January ~ December）
  */
- (NSString *)ENCutCurrentMonth;

/**
  *  英文当前日（1st 2nd 3rd。。。）
  */
- (NSString *)ENCurrentDay;

/**
  *  中文当前月(一 ~ 十二月)
  */
- (NSString *)CNCurrentMonth;

/**
  *  中文当前周(一 ~ 日)
  */
- (NSString *)CNCurrentWeekday;


/**
 *  导航栏的顶部标题
 */
- (NSString *)navigationTitle;

/**
  *  tableview的顶部标题
*/
- (NSString *)tableHeaderTitle;

/**
 *  tableview的顶部副标题
 */
- (NSString *)tableHeaderDetailTitle;


@end

NS_ASSUME_NONNULL_END
