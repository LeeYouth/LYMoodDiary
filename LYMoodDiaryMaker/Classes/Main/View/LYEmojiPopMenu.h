//
//  LYEmojiPopMenu.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/14.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYEmojiPopMenu;

#define LYEmojiPopMenuBorderWidth 10
#define LYEmojiPopMenuEmojiWidth 56

NS_ASSUME_NONNULL_BEGIN

@protocol LYEmojiPopMenuDelegate <NSObject>

@optional
- (void)lyPopupMenuBeganDismiss;
- (void)lyPopupMenuDidDismiss;
- (void)lyPopupMenuBeganShow;
- (void)lyPopupMenuDidShow;
- (void)lyPopupMenu:(LYEmojiPopMenu *)lyPopupMenu didSelectedAtIndex:(NSInteger)index;

@end


@interface LYEmojiPopMenu : UIView

- (instancetype)initRelyOnView:(UIView *)view
                        Emojis:(NSArray *)Emojis;


/**
 展示nmenu
 */
- (void)show;

/**
 回调
 */
@property (nonatomic, copy) LYViewDidSelected didSelected;

/**
 代理
 */
@property (nonatomic, weak) id <LYEmojiPopMenuDelegate> delegate;

/**
 消失
 */
- (void)dismiss;

/**
 是否显示阴影 Default is YES
 */
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;

/**
 是否显示灰色覆盖层 Default is YES
 */
@property (nonatomic, assign) BOOL showMaskView;

@end

NS_ASSUME_NONNULL_END
