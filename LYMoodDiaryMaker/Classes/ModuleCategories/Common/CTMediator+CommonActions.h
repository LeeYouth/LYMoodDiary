//
//  CTMediator+CommonActions.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/8.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (CommonActions)

/// h5通用界面
- (UIViewController *)CTMediator_PushWKWebViewController:(NSDictionary *)parmas;

@end

NS_ASSUME_NONNULL_END
