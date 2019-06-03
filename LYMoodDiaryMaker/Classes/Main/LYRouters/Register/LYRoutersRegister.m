//
//  LYRoutersRegister.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYRoutersRegister.h"

@implementation LYRoutersRegister

+ (void)registerAllRouters{
    //1.心情日记预览页
    [FFRouter registerRouteURL:kMoodDiaryPreviewRouter handler:^(NSDictionary *routerParameters) {
        LYMoodDiaryModel *model = routerParameters[kRouterParamKey];
        //进入预览
        LYMoodDiaryPreviewViewController *previewVC = [[LYMoodDiaryPreviewViewController alloc] init];
        previewVC.creatDate = model.enterDate;
        [[LYAppTool getCurrentViewController].navigationController pushViewController:previewVC animated:YES];
    }];

}

@end
