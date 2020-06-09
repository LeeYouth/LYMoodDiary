//
//  Target_Common.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/8.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "Target_Common.h"

@implementation Target_Common

/// h5通用界面
- (UIViewController *)Action_pushWKWebViewController:(NSDictionary *)params
{
    LYWKWebViewController *webVC = [[LYWKWebViewController alloc] initWithURLString:params[@"url"]];
    webVC.titleStr = params[@"title"];
    return webVC;
}

@end
