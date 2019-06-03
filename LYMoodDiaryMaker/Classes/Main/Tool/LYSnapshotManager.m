//
//  LYSnapshotManager.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/3.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYSnapshotManager.h"

@implementation LYSnapshotManager

+ (void)screenShotForTableView:(UITableView *)tableView
                    finishBlock:(void (^)(UIImage *snapShotImage))finishBlock{
    
    UIImage* image = [[UIImage alloc]init];
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。
    //如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，调整清晰度。
    UIGraphicsBeginImageContextWithOptions(tableView.contentSize, YES, [UIScreen mainScreen].scale);
    CGPoint savedContentOffset = tableView.contentOffset;
    CGRect savedFrame = tableView.frame;
    tableView.contentOffset = CGPointZero;
    tableView.frame = CGRectMake(0, 0, tableView.contentSize.width, tableView.contentSize.height);
    [tableView.layer renderInContext: UIGraphicsGetCurrentContext()];
    tableView.layer.contents = nil;//释放
    image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    tableView.contentOffset= savedContentOffset;
    tableView.frame = savedFrame;
    if (finishBlock) {
        finishBlock(image);
    }
}

@end
