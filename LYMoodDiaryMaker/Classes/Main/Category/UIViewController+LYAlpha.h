//
//  UIViewController+LYAlpha.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/31.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LYAlpha)

- (void)hiddenNavigationTitle;

- (void)showNavigationTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
