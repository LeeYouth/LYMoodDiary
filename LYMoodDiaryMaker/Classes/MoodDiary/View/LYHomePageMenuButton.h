//
//  LYHomePageMenuButton.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/1/5.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYMenuButtonCell;

@protocol LYHomePageMenuButtonDelegate <NSObject>

@optional

-(void) didSelectMenuOptionAtIndex:(NSInteger)row;

@end

@interface LYHomePageMenuButton : UIView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property NSArray      *imageArray,*labelArray;

@property id<LYHomePageMenuButtonDelegate> delegate;

@property (nonatomic, assign)  BOOL hideWhileScrolling;
@property (nonatomic, strong)  UIImageView *bgView;
@property (nonatomic, strong)  UIScrollView *bgScroller;
@property (nonatomic, strong)  UIImageView *normalImageView,*pressedImageView;
@property (nonatomic, strong)  UIWindow *mainWindow;
@property (nonatomic, strong)  UIImage *pressedImage, *normalImage;
@property (nonatomic, strong)  NSDictionary *menuItemSet;
@property (nonatomic, strong)  UIView *windowView;
@property (nonatomic, assign)  BOOL isMenuVisible;
@property (nonatomic, strong)  UITableView *menuTable;
@property (nonatomic, strong)  UIView *buttonView;


//frame 坐标  passiveImage未展开的图片 activeImage 展开后的图片 scrView底部视图用于控制滑动页面时悬浮按钮是不是还在 effect背景毛玻璃效果处理图片  w展开后小图片的宽
-(id)initWithFrame:(CGRect)frame normalImage:(UIImage*)passiveImage andPressedImage:(UIImage*)activeImage withScrollview:(UIScrollView*)scrView effectImage:(UIImage *)effect menuWidth:(CGFloat)w;

/**
 CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 60 - 20, 60, 60);
 self.menuBtn = [[LZMenuButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"cross"] withScrollview:nil effectImage:[UIImage imageNamed:@"7.jpg"] menuWidth:45];
 self.menuBtn.imageArray = @[@"fb-icon",@"twitter-icon",@"google-icon",@"linkedin-icon"];
 self.menuBtn.labelArray = @[@"Facebook",@"Twitter",@"Google Plus",@"Linked in"];
 self.menuBtn.hideWhileScrolling = NO;
 self.menuBtn.delegate = self;
 [self.view addSubview:self.menuBtn];
 
 */


@end




@interface LYMenuButtonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) UIImageView *iconImageV;

@end
