//
//  UIViewController+presentVC.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/4.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "UIViewController+presentVC.h"
#import <objc/runtime.h>

@implementation UIViewController (presentVC)

+ (void)load{


    // 适配ios  13  这里做方法交换
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 系统模态方法，  做方法交换
        Method systemPresent = class_getInstanceMethod(self,@selector(presentViewController:animated:completion:));
        Method custom_Method = class_getInstanceMethod(self,@selector(lyPresentViewController:animated:completion:));
        method_exchangeImplementations(systemPresent, custom_Method);
    });

}
- (void)lyPresentViewController:(UIViewController*)viewControllerToPresent animated:(BOOL)animated completion:(void(^)(void))completion {

    if(@available(iOS 13.0, *)) {
//        Class presentVC = NSClassFromString(@"LYWriteMoodDiaryViewController");
         viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
     }
    [self lyPresentViewController:viewControllerToPresent animated:animated completion:completion];
}

@end
