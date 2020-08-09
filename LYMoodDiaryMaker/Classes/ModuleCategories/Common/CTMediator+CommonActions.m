//
//  CTMediator+CommonActions.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/8.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "CTMediator+CommonActions.h"

NSString *const kLYTarget_Common = @"Common";
NSString *const kLYActionPushWKWebViewController = @"pushWKWebViewController";

@implementation CTMediator (CommonActions)

/// h5通用界面
- (UIViewController *)CTMediator_PushWKWebViewController:(NSDictionary *)parmas
{
    return [self performTarget:kLYTarget_Common
                        action:kLYActionPushWKWebViewController
                        params:parmas
             shouldCacheTarget:NO
    ];
}

@end
