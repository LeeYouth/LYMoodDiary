//
//  LYBaseCustomTableHeaderViewProtocol.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/21.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYBaseCustomTableHeaderViewProtocol <NSObject, BHServiceProtocol>

/** 标题 */
@property(nonatomic, copy) NSString *title;

/** 副标题 */
@property(nonatomic, copy) NSString *detailTitle;

@end
