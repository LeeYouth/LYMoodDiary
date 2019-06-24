//
//  LYWriteMoodDiaryGuideView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/24.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYWriteMoodDiaryGuideView : UIView

/** 初始化 */
- (instancetype)initWithGuideType:(NSString *)guideType;

/** 图片 */
@property (nonatomic, strong) UIImage *iconImage;
/** 标题 */
@property (nonatomic, copy) NSString *title;

/**
 展示nmenu
 */
- (void)show;

/**
 是否显示灰色覆盖层 Default is YES
 */
@property (nonatomic, assign) BOOL showMaskView;

@end
