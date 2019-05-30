//
//  LYMoodDiaryModel.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h" //添加该头文件,本类就具有了存储功能.

typedef enum : NSUInteger {
    LYMoodDiaryHappy,
    LYMoodDiarySad,
    LYMoodDiaryMad,
    LYMoodDiaryInLove,
    LYMoodDiaryCool,
    LYMoodDiaryCry,
    LYMoodDiarySleeping,
    LYMoodDiaryHungry,
} LYMoodDiaryType;

NS_ASSUME_NONNULL_BEGIN

@interface LYMoodDiaryModel : NSObject

/** 当前心情类型 */
@property(nonatomic, assign) LYMoodDiaryType moodType;
/** 当前输入的心情文字 */
@property(nonatomic, copy)   NSString *moodDiaryText;
/** 表情图片名 */
@property(nonatomic, copy)   NSString *typeName;
/** 当前表情的背景颜色 */
@property(nonatomic, strong) UIColor *moodColor;
/** 最后保存的日期date */
@property(nonatomic, strong) NSDate *uploadDate;
/** 第一次编辑的时间 */
@property(nonatomic, strong) NSDate *enterDate;
/** 最后一次编辑的时间  */
@property(nonatomic, strong) NSDate *editDate;

/** 日期格式(2017-11-30) */
@property(nonatomic, copy)   NSString *saveFormatDate;

+ (LYMoodDiaryType)matchTypeWithEmojiType:(NSString *)type;

+ (NSString *)matchEmojiTypeWithType:(LYMoodDiaryType)type;

+ (NSString *)matchEmojiNameWithType:(LYMoodDiaryType)type;

@end

NS_ASSUME_NONNULL_END
