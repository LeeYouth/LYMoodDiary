//
//  LYTWatermarkBottomToolBar.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  底部按钮工具栏

#import <UIKit/UIKit.h>
#import "LYWatermarkColorsListView.h"
#import "LYWatermarkBottomBtnsView.h"

@interface LYTWatermarkBottomToolBar : UIView

/** 点击颜色 */
@property(nonatomic, copy) LYWatermarkColorsListViewDidSelectColorHexBlock didSelectItemblock;
/** 点击背景颜色 */
@property(nonatomic, copy) LYWatermarkColorsListViewDidSelectBackBlock didSelectBackblock;
/** 底部按钮点击 */
@property(nonatomic, copy) LYWatermarkBottomBtnsViewBlock bottomBtnblock;

@end
