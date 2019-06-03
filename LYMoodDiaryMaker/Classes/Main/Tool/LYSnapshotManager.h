//
//  LYSnapshotManager.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYSnapshotManager : NSObject

/** 截取tableView的图 */
+ (void)screenShotForTableView:(UITableView *)tableView
                   finishBlock:(void (^)(UIImage *snapShotImage))finishBlock;

@end

NS_ASSUME_NONNULL_END
