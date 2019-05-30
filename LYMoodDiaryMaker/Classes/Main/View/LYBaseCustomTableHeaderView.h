//
//  LYBaseCustomTableHeaderView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/13.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYBaseCustomTableHeaderView : UIView

/** 标题 */
@property(nonatomic, copy) NSString *title;

/** 副标题 */
@property(nonatomic, copy) NSString *detailTitle;

@end

NS_ASSUME_NONNULL_END
