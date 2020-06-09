//
//  UITableViewCell+Addtidions.m
//  LYMoodDiaryMaker
//
//  Created by yuanliyong on 2020/6/8.
//  Copyright © 2020 LYoung_iOS. All rights reserved.
//

#import "UITableViewCell+Addtidions.h"

@implementation UITableViewCell (Addtidions)

//+ (void)load
//{
//    // 适配ios  13  这里做方法交换
//       static dispatch_once_t onceToken;
//       dispatch_once(&onceToken, ^{
//           // 系统模态方法，  做方法交换
//           Method systemPresent = class_getInstanceMethod(self,@selector(setSelectedBackgroundView:));
//           Method custom_Method = class_getInstanceMethod(self,@selector(ly_setSelectedBackgroundView:));
//           method_exchangeImplementations(systemPresent, custom_Method);
//       });
//}
//- (void)ly_setSelectedBackgroundView:(UIView *)view
//{
////    if(self.selectedBackgroundEnabled){
//    UIView *backV = [UIView new] ;
////    backV.dk_backgroundColorPicker = DKColorPickerWithColors(LYHexRGBAlpha(0xfafafa, 0.5),LYHexRGBAlpha(0xffffff, 0.1));
////    backV.backgroundColor = red_color;
////    self.selectedBackgroundView = backV;
////    self.selectedBackgroundView.backgroundColor = red_color;
////    }
//    [self ly_setSelectedBackgroundView:view];
//    
//    self.selectionStyle= UITableViewCellSelectionStyleGray;
//    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage createImageWithColor:[UIColor yellowColor]]];
////    self.selectedBackgroundView.backgroundColor = [UIColor yellowColor];
//
//}
//
//- (void)ly_enableSelectedBackground
//{
//    [self setSelectedBackgroundEnabled:YES];
////    self.selectedBackgroundView = [[UIView alloc] init];
//}
//
//- (void)setSelectedBackgroundEnabled:(BOOL)selectedBackgroundEnabled
//{
//    objc_setAssociatedObject(self, @"kSelectedBackgroundEnabledKey", @(selectedBackgroundEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

@end
