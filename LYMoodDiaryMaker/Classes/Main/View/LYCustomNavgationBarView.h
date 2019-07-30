//
//  LYCustomNavgationBarView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/7.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYCustomNavgationBarViewBlcok)(UIButton *sender);

@interface LYCustomNavgationBarView : UIView

/** 导航栏颜色(默认为) */
@property (nonatomic, strong) UIColor *navColor;
/** 导航栏title大小(默认16.f.f) */
@property (nonatomic, strong) UIFont *navTitleFont;
/** 导航栏左侧按钮(默认为x号) */
@property (nonatomic, strong) UIImage *leftBarItemImage;
/** 导航栏右侧侧按钮(默认为对号) */
@property (nonatomic, strong) UIImage *rightBarItemImage;
/** 导航栏右侧标题 */
@property (nonatomic, copy) NSString *rightItemTitle;

/** 标题图片 */
@property (nonatomic, strong) UIImage *titleImage;

/** 导航栏title */
@property (nonatomic, copy) NSString *navBarTitle;
/** 是否显示阴影(默认为NO) */
@property (nonatomic, assign) BOOL showShadow;
/** 展示分割线 (默认为no)*/
@property (nonatomic, assign) BOOL showLineView;

@property(nonatomic, copy) LYCustomNavgationBarViewBlcok btnBlock;


@end
