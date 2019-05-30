//
//  LYEmojiPopMenu.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/14.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYEmojiPopMenu.h"
#import "LYEmojiPopMenuItem.h"
#import "LYEmojiPopMenuPath.h"

#define LYEmojiPopMenuMaxCount 5

@interface LYEmojiPopMenu()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView      * menuBackView;
@property (nonatomic, strong) NSArray     * Emojis;
@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic) CGPoint                point;
@property (nonatomic) CGRect                 relyRect;

@property (nonatomic) CGFloat                arrowHeight;
@property (nonatomic) CGFloat                arrowWidth;
@property (nonatomic) CGFloat                itemWidth;
@property (nonatomic) CGFloat                minSpace;
@property (nonatomic) CGFloat                arrowPosition;

@end

@implementation LYEmojiPopMenu

- (instancetype)initRelyOnView:(UIView *)view
                        Emojis:(NSArray *)Emojis{
    if ([super init]) {
        CGRect absoluteRect = [view convertRect:view.bounds toView:LYMainWindow];
        CGPoint relyPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y + absoluteRect.size.height);
        _point    = relyPoint;
        _relyRect = absoluteRect;
        _Emojis   = Emojis;
        
        [self setDefaultSettings];
    }
    return self;
}

- (void)setDefaultSettings{
    self.isShowShadow = YES;
    
    _itemWidth   = LYEmojiPopMenuEmojiWidth;
    _arrowWidth  = 15.0;
    _arrowHeight = 10.f;
    _minSpace    = LYEmojiPopMenuBorderWidth;
    _arrowPosition = _itemWidth/2;
    _menuBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _menuBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    _menuBackView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
    [_menuBackView addGestureRecognizer: tap];
    self.alpha = 0;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    
    [self updateUI];
}

#pragma mark - privates
- (void)show{
    [LYMainWindow addSubview:_menuBackView];
    [LYMainWindow addSubview:self];

    if (self.delegate && [self.delegate respondsToSelector:@selector(lyPopupMenuBeganShow)]) {
        [self.delegate lyPopupMenuBeganShow];
    }
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    __weak UIView *weakView = _menuBackView;
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
        weakView.alpha = 1;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPopupMenuDidShow)]) {
            [self.delegate lyPopupMenuDidShow];
        }
    }];
}

- (void)dismiss{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lyPopupMenuBeganDismiss)]) {
        [self.delegate lyPopupMenuBeganDismiss];
    }
    __weak UIView *weakView = _menuBackView;
    WEAKSELF(weakSelf);
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
        weakView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPopupMenuDidDismiss)]) {
            [self.delegate lyPopupMenuDidDismiss];
        }
        self.delegate = nil;
        [self removeFromSuperview];
        [weakView removeFromSuperview];
    }];
}

- (void)touchOutSide{
    [self dismiss];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [LYEmojiPopMenuItem getCollectionCellSize];
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return _Emojis.count >LYEmojiPopMenuMaxCount?LYEmojiPopMenuBorderWidth:0.0000001;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    //每个item间距
    return LYEmojiPopMenuBorderWidth;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //左右距边距的距离20
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYEmojiPopMenuItem *cell = [LYEmojiPopMenuItem cellWithCollectionView:collectionView forItemAtIndexPath:indexPath];
    cell.emojiType = _Emojis[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _Emojis.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelected) {
        self.didSelected(indexPath.row);
    }
    [self dismiss];
}

- (void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
}
- (void)setShowMaskView:(BOOL)showMaskView{
    _showMaskView = showMaskView;
    _menuBackView.backgroundColor = showMaskView ? [[UIColor blackColor] colorWithAlphaComponent:0.1] : [UIColor clearColor];
}

- (void)updateUI{
    int maxCount = LYEmojiPopMenuMaxCount;
    
    CGFloat height = _itemWidth  + _minSpace * 2;
    CGFloat width  = _Emojis.count * _itemWidth + (_Emojis.count + 1) * _minSpace;
    if (_Emojis.count > maxCount) {
        width  = maxCount * _itemWidth + (maxCount + 1) * _minSpace;
        height = 2*_itemWidth + _minSpace * (maxCount - 1);
    }

    [self setRelyRect];
    
    CGFloat y = _point.y - _arrowHeight - height;
    self.frame = CGRectMake(_point.x - _itemWidth/2 - _minSpace, y, width, height + _arrowHeight);

    [self.collectionView reloadData];
    [self setNeedsDisplay];
}
- (void)setRelyRect{
    if (CGRectEqualToRect(_relyRect, CGRectZero)) {
        return;
    }
    _point.y = _relyRect.origin.y;
}


- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.collectionView.frame = CGRectMake(_minSpace, _minSpace, frame.size.width - _minSpace * 2, frame.size.height - _arrowHeight - 2*_minSpace);

}


- (void)drawRect:(CGRect)rect{
    
    CGFloat cornerRadius = 30.f;
    CGFloat borderWidth  = 0.8;
    UIColor *borderColor = LYColor(@"#E8E8E8");
    
    UIBezierPath *bezierPath = [LYEmojiPopMenuPath ly_bezierPathWithRect:rect rectCorner:UIRectCornerAllCorners cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor backgroundColor:[UIColor whiteColor] arrowWidth:_arrowWidth arrowHeight:_arrowHeight arrowPosition:_arrowPosition arrowDirection:LYPopupMenuArrowDirectionBottom];
    [bezierPath fill];
    [bezierPath stroke];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}
@end
