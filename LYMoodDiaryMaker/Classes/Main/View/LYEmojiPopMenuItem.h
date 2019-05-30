//
//  LYEmojiPopMenuItem.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/14.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYEmojiPopMenuItem : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath;
+ (CGSize)getCollectionCellSize;
@property(nonatomic, copy) NSString *emojiType;

@end

NS_ASSUME_NONNULL_END
