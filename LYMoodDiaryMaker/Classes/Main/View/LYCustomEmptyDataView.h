//
//  LYCustomEmptyDataView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/17.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCustomEmptyDataView : UIView

/** 标题 */
@property(nonatomic, copy) NSString *title;
/** fu标题 */
@property(nonatomic, copy) NSString *detailTitle;
/** 按钮标题 */
@property(nonatomic, copy) NSString *buttonTitle;
/** 回调 */
@property (nonatomic, copy) LYViewDidSelected didSelected;


@end

NS_ASSUME_NONNULL_END
