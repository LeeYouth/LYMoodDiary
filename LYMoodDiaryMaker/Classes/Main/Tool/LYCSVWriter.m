//
//  LYCSVWriter.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/20.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYCSVWriter.h"

#define LYCSVWriteMoodFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myMoodList.csv"]

@interface LYCSVWriter ()

@end


@implementation LYCSVWriter


+ (NSString *)exportCSVWithMoods:(NSArray *)moods {
    
    NSString *fileName = LYCSVWriteMoodFilePath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];
    if (![fileManager createFileAtPath:fileName contents:nil attributes:nil]) {
        LYLog(@"不能创建文件");
    }
    
    NSOutputStream *output = [[NSOutputStream alloc] initToFileAtPath:fileName append:YES];
    [output open];
    if (![output hasSpaceAvailable]) {
        LYLog(@"没有足够可用空间");
    } else {
        NSString *header = @"Date,text,mood\n";
        const uint8_t *headerString = (const uint8_t *)[header cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger headerLength = [header lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSInteger result = [output write:headerString maxLength:headerLength];
        if (result <= 0) {
            LYLog(@"写入错误");
        }
        NSString *formatStr = @"yyyy-MM-dd HH:mm";

        for (LYMoodDiaryModel *model in moods) {
            
            NSString *date = [NSString stringWithFormat:@"%@",[model.enterDate stringWithFormat:formatStr]];
            NSString *text  = [NSString stringWithFormat:@"%@",model.moodDiaryText];
            
            NSString *newText = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
            newText = [newText stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            newText = [newText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            NSString *mood  = [NSString stringWithFormat:@"%@",[LYMoodDiaryModel matchEmojiNameWithType:model.moodType]];
            
            NSString *row = [NSString stringWithFormat:@"%@,%@,%@\n", date, mood, newText];
            const uint8_t *rowString = (const uint8_t *)[row cStringUsingEncoding:NSUTF8StringEncoding];
            NSInteger rowLength = [row lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            result = [output write:rowString maxLength:rowLength];
            if (result <= 0) {
                LYLog(@"无法写入内容");
            }
        }
        [output close];
    }
    return fileName;
}

@end


