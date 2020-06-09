//
//  LYFuncTestViewController.h
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/8.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "LYBaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYFuncTestViewController : LYBaseViewController

/**
 nav的title（选填）
 */
@property (nonatomic, copy) NSString *titleStr;


/**
 初始化网页加载控制器
 
 @param urlString URL地址字符串
 @return 控制器
 */
- (instancetype)initWithURLString:(NSString*)urlString;


/**
 初始化网页加载控制器
 
 @param url URL地址
 @return 控制器
 */
- (instancetype)initWithURL:(NSURL*)url;

@end

NS_ASSUME_NONNULL_END
