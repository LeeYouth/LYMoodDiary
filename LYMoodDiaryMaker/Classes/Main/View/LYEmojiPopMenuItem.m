//
//  LYEmojiPopMenuItem.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/14.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYEmojiPopMenuItem.h"

@interface LYEmojiPopMenuItem()

@property (nonatomic, strong) UIImageView *iconImageView;//图片

@end

@implementation LYEmojiPopMenuItem

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView registerClass:[LYEmojiPopMenuItem class] forCellWithReuseIdentifier:@"LYEmojiPopMenuItem"];
    LYEmojiPopMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYEmojiPopMenuItem" forIndexPath:indexPath];
    return cell;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setupSubViews];
    }
    return self;
}

+ (CGSize)getCollectionCellSize{
    CGFloat iconW = 56.f;
    return CGSizeMake(iconW, iconW);
}

- (void)_setupSubViews{
    [self addSubview:self.iconImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    
}
- (void)setEmojiType:(NSString *)emojiType{
    _emojiType = emojiType;
    self.iconImageView.image = [UIImage imageWithEmojiType:emojiType];
}

- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        UIImageView *view = [[UIImageView alloc] init];
//        view.layer.cornerRadius = [LYEmojiPopMenuItem getCollectionCellSize].width/2;
//        view.layer.masksToBounds = YES;
        [self addSubview:view];
        view;
    }));
}


@end
