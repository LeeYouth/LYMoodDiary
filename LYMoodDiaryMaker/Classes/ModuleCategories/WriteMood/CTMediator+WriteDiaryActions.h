//
//  CTMediator+WriteDiaryActions.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (WriteDiaryActions)

- (UIViewController *)CTMediator_WriteMoodDiaryViewController:(nullable NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
