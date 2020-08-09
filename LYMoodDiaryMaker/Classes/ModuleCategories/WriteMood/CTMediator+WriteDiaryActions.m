//
//  CTMediator+WriteDiaryActions.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator+WriteDiaryActions.h"
NSString *const kLYTarget_WriteMood = @"WriteMood";
NSString *const kLYActionPresentWriteMoodDiaryViewController = @"presentWriteMoodDiaryViewController";

@implementation CTMediator (WriteDiaryActions)

- (UIViewController *)CTMediator_WriteMoodDiaryViewController:(nullable NSDictionary *)params
{
    return [self performTarget:kLYTarget_WriteMood
                        action:kLYActionPresentWriteMoodDiaryViewController
                        params:params
             shouldCacheTarget:NO
    ];
}

@end
