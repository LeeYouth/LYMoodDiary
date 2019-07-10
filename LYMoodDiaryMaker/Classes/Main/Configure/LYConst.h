//
//  LYConst.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  常量配置

#import <UIKit/UIKit.h>

// 友盟AppKey
UIKIT_EXTERN NSString *const UM_APPKEY;

//分享
UIKIT_EXTERN NSString *const WECHAT_APPKEY;
UIKIT_EXTERN NSString *const WECHAT_APPSECRET;


//表情类型
UIKIT_EXTERN NSString *const LYEMOJI_HAPPY;
UIKIT_EXTERN NSString *const LYEMOJI_SAD;
UIKIT_EXTERN NSString *const LYEMOJI_MAD;
UIKIT_EXTERN NSString *const LYEMOJI_INLOVE;
UIKIT_EXTERN NSString *const LYEMOJI_COOL;
UIKIT_EXTERN NSString *const LYEMOJI_CRY;
UIKIT_EXTERN NSString *const LYEMOJI_SLEEP;
UIKIT_EXTERN NSString *const LYEMOJI_HUNGRY;

//保存的心情表名
UIKIT_EXTERN NSString *const kLYMOODTABLENAME;


//根据日期搜索的format(格式yyyy-MM-dd)
UIKIT_EXTERN NSString *const kSEARCHDATEFORMAT;
//列表头部标题日期显示format(yyyy)
UIKIT_EXTERN NSString *const kHEADERTITLEDATEFORMAT;
//列表头部副标题日期显示format(MM-dd)
UIKIT_EXTERN NSString *const kHEADERDETAILTITLEDATEFORMAT;
//列表头部显示format(yyyy/MM/dd)
UIKIT_EXTERN NSString *const kHEADERFULLDATEFORMAT;
//列表日期显示format(HH:mm)
UIKIT_EXTERN NSString *const kLISTCELLDATEFORMAT;

//首页引导
UIKIT_EXTERN NSString *const kHOMEPAGEGUIDEINDENTIFER;

//是否开启了密码
UIKIT_EXTERN NSString *const kHASOPENPASSCODESWITCH;

//是否已设置了密码
UIKIT_EXTERN NSString *const kHASOPENPASSCODESTRING;

//是否开启了touch id密码按钮
UIKIT_EXTERN NSString *const kHASOPENPASSCODETOUCHID;



UIKIT_EXTERN NSString *const LYPasscodeKeychainServiceName;
