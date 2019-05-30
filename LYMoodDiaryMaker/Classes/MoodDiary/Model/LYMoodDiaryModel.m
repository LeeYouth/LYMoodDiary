//
//  LYMoodDiaryModel.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/10.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYMoodDiaryModel.h"

@implementation LYMoodDiaryModel

- (void)setMoodType:(LYMoodDiaryType)moodType{
    _moodType = moodType;

    if (moodType == LYMoodDiaryHappy) {
        
        self.typeName   = LYEMOJI_HAPPY;
        self.moodColor  = [UIColor happyColor];
    }else if (moodType == LYMoodDiarySad){
        self.typeName   = LYEMOJI_SAD;
        self.moodColor  = [UIColor sadColor];
    }else if (moodType == LYMoodDiaryMad){
        self.typeName   = LYEMOJI_MAD;
        self.moodColor  = [UIColor madColor];
    }else if (moodType == LYMoodDiaryInLove){
        self.typeName   = LYEMOJI_INLOVE;
        self.moodColor  = [UIColor inLoveColor];
    }else if (moodType == LYMoodDiaryCool){
        self.typeName   = LYEMOJI_COOL;
        self.moodColor  = [UIColor coolColor];
    }else if (moodType == LYMoodDiaryCry){
        self.typeName   = LYEMOJI_CRY;
        self.moodColor  = [UIColor cryColor];
    }else if (moodType == LYMoodDiarySleeping){
        self.typeName   = LYEMOJI_SLEEP;
        self.moodColor  = [UIColor sleepColor];
    }else if (moodType == LYMoodDiaryHungry){
        self.typeName   = LYEMOJI_HUNGRY;
        self.moodColor  = [UIColor hungryColor];
    }
}

- (void)setEnterDate:(NSDate *)enterDate{
    _enterDate = enterDate;
    
    self.saveFormatDate = [enterDate stringWithFormat:@"yyyy-MM-dd"];
}

+ (LYMoodDiaryType)matchTypeWithEmojiType:(NSString *)type{

    LYMoodDiaryType moodType = LYMoodDiaryHappy;
    if ([type isEqualToString:LYEMOJI_HAPPY]) {
        return moodType = LYMoodDiaryHappy;
    }else if ([type isEqualToString:LYEMOJI_INLOVE]){
        return moodType = LYMoodDiaryInLove;
    }else if ([type isEqualToString:LYEMOJI_MAD]){
        return moodType = LYMoodDiaryMad;
    }else if ([type isEqualToString:LYEMOJI_SAD]){
        return moodType = LYMoodDiarySad;
    }else if ([type isEqualToString:LYEMOJI_COOL]){
        return moodType = LYMoodDiaryCool;
    }else if ([type isEqualToString:LYEMOJI_CRY]){
        return moodType = LYMoodDiaryCry;
    }else if ([type isEqualToString:LYEMOJI_SLEEP]){
        return moodType = LYMoodDiarySleeping;
    }else if ([type isEqualToString:LYEMOJI_HUNGRY]){
        return moodType = LYMoodDiaryHungry;
    }
    return moodType;
}

+ (NSString *)matchEmojiTypeWithType:(LYMoodDiaryType)type{
    NSString *moodType = LYEMOJI_HAPPY;
    if (type == LYMoodDiaryHappy) {
        return moodType = LYEMOJI_HAPPY;
    }else if (type == LYMoodDiaryInLove){
        return moodType = LYEMOJI_INLOVE;
    }else if (type == LYMoodDiaryMad){
        return moodType = LYEMOJI_MAD;
    }else if (type == LYMoodDiarySad){
        return moodType = LYEMOJI_SAD;
    }else if (type == LYMoodDiaryCool){
        return moodType = LYEMOJI_COOL;
    }else if (type == LYMoodDiaryCry){
        return moodType = LYEMOJI_CRY;
    }else if (type == LYMoodDiarySleeping){
        return moodType = LYEMOJI_SLEEP;
    }else if (type == LYMoodDiaryHungry){
        return moodType = LYEMOJI_HUNGRY;
    }
    
    
    return moodType;
}

+ (NSString *)matchEmojiNameWithType:(LYMoodDiaryType)type{
    NSString *moodType = LYEMOJI_HAPPY;
    if (type == LYMoodDiaryHappy) {
        return LY_LocalizedString(@"kLYMoodNameHappy");
    }else if (type == LYMoodDiaryInLove){
        return LY_LocalizedString(@"kLYMoodNameInLove");
    }else if (type == LYMoodDiaryMad){
        return LY_LocalizedString(@"kLYMoodNameMad");
    }else if (type == LYMoodDiarySad){
        return LY_LocalizedString(@"kLYMoodNameSad");
    }else if (type == LYMoodDiaryCool){
        return LY_LocalizedString(@"kLYMoodNameCool");
    }else if (type == LYMoodDiaryCry){
        return LY_LocalizedString(@"kLYMoodNameCry");
    }else if (type == LYMoodDiarySleeping){
        return LY_LocalizedString(@"kLYMoodNameSleep");
    }else if (type == LYMoodDiaryHungry){
        return LY_LocalizedString(@"kLYMoodNameHungry");
    }
    return moodType;
}
@end
