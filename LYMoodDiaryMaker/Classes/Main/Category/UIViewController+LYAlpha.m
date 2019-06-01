//
//  UIViewController+LYAlpha.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/31.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "UIViewController+LYAlpha.h"

@implementation UIViewController (LYAlpha)

- (void)hiddenNavigationTitle{
    self.title = @"";
}

- (void)showNavigationTitle:(NSString *)title{
    self.title = title;
}
@end
