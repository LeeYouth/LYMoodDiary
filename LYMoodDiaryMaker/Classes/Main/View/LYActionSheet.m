
//
//  LYActionSheet.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/18.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYActionSheet.h"

@interface LYActionSheet()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView      * menuBackView;
@property (nonatomic, strong) NSArray     * sheetTitles;

@property (nonatomic, strong) UIView      * titleBackView;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UIView      * lineView;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton    * cancelButton;


@property (nonatomic) CGFloat                itemHeight;
@property (nonatomic) CGFloat                minSpace;
@property (nonatomic) CGFloat                cancelSpace;
@property (nonatomic) CGFloat                titleHeight;

@end

@implementation LYActionSheet

- (instancetype)initWithSheetTitles:(NSArray *)sheetTitles{
    if ([super init]) {

        _sheetTitles = sheetTitles;
        
        [self setDefaultSettings];
    }
    return self;
}

- (void)setDefaultSettings{
    
    _cancelSpace  = 8;
    _minSpace     = kLYContentLeftMargin;
    _itemHeight   = 68;
    _titleHeight  = _itemHeight;
    _menuBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _menuBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    _menuBackView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
    [_menuBackView addGestureRecognizer: tap];
    self.alpha = 0;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.titleBackView];
    [self.titleBackView addSubview:self.titleLabel];
    [self.titleBackView addSubview:self.lineView];

    [self updateUI];
}

#pragma mark - privates
- (void)show{
    [LYMainWindow addSubview:_menuBackView];
    [LYMainWindow addSubview:self];
 
    __weak UIView *weakView = _menuBackView;
    self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
    [UIView animateWithDuration: 0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
        self.alpha = 1;
        weakView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss{
    
    __weak UIView *weakView = _menuBackView;
    [UIView animateWithDuration: 0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
        self.alpha = 0;
        weakView.alpha = 0;
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
        [weakView removeFromSuperview];
    }];
}

- (void)touchOutSide{
    [self dismiss];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sheetTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _itemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYActionSheetViewCell *cell = [LYActionSheetViewCell cellWithTableView:tableView];
    cell.title = _sheetTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didSelected) {
        self.didSelected(indexPath.row);
    }
    [self dismiss];

}

- (void)setShowMaskView:(BOOL)showMaskView{
    _showMaskView = showMaskView;
    _menuBackView.backgroundColor = showMaskView ? [[UIColor blackColor] colorWithAlphaComponent:0.2] : [UIColor clearColor];
}

- (void)setItemHeight:(CGFloat)itemHeight{
    _itemHeight = itemHeight;
    [self updateUI];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self updateUI];
}

- (void)updateUI{
    
    CGFloat titleH = self.title.length?_titleHeight:0;
    CGFloat height = titleH + _sheetTitles.count*_itemHeight + _cancelSpace + _itemHeight + kTabbarExtra;
    
    CGFloat y = kScreenHeight - height;
    self.frame = CGRectMake(0, y, kScreenWidth, height);
    
    [self.tableView reloadData];
    [self setNeedsDisplay];
}



- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    CGFloat tableViewH = _sheetTitles.count*_itemHeight + _cancelSpace;
    CGFloat titleH = self.title.length?_titleHeight:0;
    self.titleBackView.frame = CGRectMake(0, 0, kScreenWidth, titleH);
    self.tableView.frame = CGRectMake(0, titleH, kScreenWidth, tableViewH);
    self.cancelButton.frame = CGRectMake(0, titleH + tableViewH, kScreenWidth, _itemHeight);
    
    self.titleLabel.frame = CGRectMake(kLYContentLeftMargin, 10, kScreenWidth - 2*kLYContentLeftMargin, _itemHeight - 20);
    self.lineView.frame   = CGRectMake(0, _itemHeight - 0.9, kScreenWidth, 0.9);
    
    self.titleLabel.text = self.title;
    self.titleLabel.hidden = !self.title.length;
    self.titleBackView.hidden = !self.title.length;
    self.lineView.hidden = !self.title.length;

}

- (void)closeButtonAction:(UIButton *)sender{
    //取消按钮
    if (self.didSelected) {
        self.didSelected(10000);
    }
    [self dismiss];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = sepLineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        [_cancelButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:LYHexRGB(0x444444) forState:UIControlStateNormal];
        [_cancelButton setTitle:LY_LocalizedString(@"kLYSheetCancel") forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = HPR18;
        [_cancelButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIView *)titleBackView{
    if (!_titleBackView) {
        _titleBackView = [UIView new];
        _titleBackView.backgroundColor = [UIColor whiteColor];
    }
    return _titleBackView;
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYHexRGB(0x999999);
        view.textAlignment = NSTextAlignmentCenter;
        view.font = HPL14;
        view.numberOfLines = 0;
        view;
    }));
}
- (UIView *)lineView{
    return LY_LAZY(_lineView, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = sepLineColor;
        view;
    }));
}
@end



@interface LYActionSheetViewCell ()

@property (nonatomic, strong) UILabel *titleVew;
/** 顶部线条 */
@property (nonatomic, strong) UIView *topLine;

@end

@implementation LYActionSheetViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"LYActionSheetViewCell";
    LYActionSheetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[LYActionSheetViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = white_color;
        
        [self _setupSubViews];
        
        
    }
    return self;
}

- (void)_setupSubViews{
    [self addSubview:self.titleVew];
    [self addSubview:self.topLine];
    
    CGFloat leftMagin = kLYContentLeftMargin;
    
    [self.titleVew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(leftMagin);
        make.right.equalTo(self.mas_right).offset(-leftMagin);
        make.height.mas_equalTo(@30);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleVew);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@0.7);
    }];
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleVew.text = title;
    if ([title isEqualToString:LY_LocalizedString(@"kLYSheetDelete")]) {
        self.titleVew.textColor = themeButtonColor;
    }else{
        self.titleVew.textColor = black_color;
    }
}

#pragma - lazy loading
- (UILabel *)titleVew{
    return LY_LAZY(_titleVew, ({
        UILabel *view = [UILabel new];
        view.textColor = black_color;
        view.textAlignment = NSTextAlignmentCenter;
        view.font = HPR18;
        view;
    }));
}
- (UIView *)topLine{
    return LY_LAZY(_topLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = sepLineColor;
        view;
    }));
}
@end
