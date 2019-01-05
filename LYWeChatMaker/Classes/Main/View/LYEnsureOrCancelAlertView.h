//
//  LYEnsureOrCancelAlertView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYEnsureOrCancelAlertView : UIView

/** 快速构造方法 */
+ (instancetype)sharedInstance;

/** 显示弹框 */
- (void)showInViewWithTitle:(NSString *)title
                  leftTitle:(NSString *)leftTitle
                 rightTitle:(NSString *)rightTitle
                   animated:(BOOL)animated;

/** 关闭当前pickView */
- (void)close;

@property(nonatomic, copy) LYButtonClickBlock btnBlock;

@end
