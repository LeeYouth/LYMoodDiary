//
//  LYMacro.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#ifndef LYMacro_h
#define LYMacro_h


#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define iOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)
#define LYMainWindow  [UIApplication sharedApplication].keyWindow
//懒加载
#define LY_LAZY(object, assignment) (object = object ?: assignment)
//NSUserDefaults本地化
#define kUserDefault [NSUserDefaults standardUserDefaults]


#define LYBUNDLE_NAME @"LYResources.bundle"
#define LYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: LYBUNDLE_NAME]
//加载plist文件
#define LYBUNDLE_PLISTPATH(name)  [[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:(name) ofType:@"plist"]
#define LYBUNDLE_IMAGEPATH(name)  [[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:(name) ofType:@"png"]

//加载bundle图片
#define LYLOADBUDLEIMAGE(bundleName,sourceName) ({\
NSString *tmp = @"";\
if ([[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: (bundleName)]] pathForResource:(sourceName) ofType:@"jpg"].length) {\
tmp = [[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: (bundleName)]] pathForResource:(sourceName) ofType:@"jpg"];\
}else{\
tmp = [[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: (bundleName)]] pathForResource:(sourceName) ofType:@"png"];\
}\
tmp;\
})



#endif /* LYMacro_h */
