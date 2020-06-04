//
//  Target_WriteMood.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_WriteMood : NSObject

/// 写 or 编辑
- (UIViewController *)Action_presentWriteMoodDiaryViewController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
