//
//  LYRectConst.h
//  LYMoodDiaryMaker
//
//  Created by liyong yuan on 2019/7/30.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#ifndef LYRectConst_h
#define LYRectConst_h

//是否iPhoneX及以后的设备 1:iPhoneX屏幕 0:传统屏幕
#define kiPhoneXLater ({\
int tmp = 0;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
tmp = 1;\
}else{\
tmp = 0;\
}\
}else{\
tmp = 0;\
}\
tmp;\
})
#define kNavBarExtra (kiPhoneXLater?24:0)
#define kTabbarExtra (kiPhoneXLater?34:0)
#define STATUSBAR_HEIGHT (kiPhoneXLater?24:20)
#define NAVBAR_HEIGHT (64 + kNavBarExtra)
#define TABBAR_HEIGHT (49 + kTabbarExtra)

//屏幕宽高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#endif /* LYRectConst_h */
