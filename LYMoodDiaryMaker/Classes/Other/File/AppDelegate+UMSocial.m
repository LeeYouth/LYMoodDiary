//
//  AppDelegate+UMSocial.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "AppDelegate+UMSocial.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

@implementation AppDelegate (UMSocial)

- (void)LYUMSocialApplication:(UIApplication *)application  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:UM_APPKEY channel:@"App Store"];

    //友盟分享
    [self configUSharePlatforms];
    [self confitUShareSettings];
}

- (void)configUSharePlatforms{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
- (void)confitUShareSettings{
    /* 设置wechat的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APPKEY appSecret:WECHAT_APPSECRET redirectURL:@"http://mobile.umeng.com/social"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
    }
    return result;
}


@end
