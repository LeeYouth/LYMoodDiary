//
//  LYTouchIDSwitchView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYTouchIDSwitchViewDelegate;


@interface LYTouchIDSwitchView : UIView

@property (nonatomic, weak) id<LYTouchIDSwitchViewDelegate> delegate;

@property (nonatomic, strong) UIView        *switchBackgroundView;
@property (nonatomic, strong) UILabel       *messageLabel;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UISwitch      *touchIDSwitch;
@property (nonatomic, strong) UIButton      *doneButton;

@end


@protocol LYTouchIDSwitchViewDelegate <NSObject>

- (void)touchIDSwitchViewDidPressDoneButton:(LYTouchIDSwitchView *)view;

@end
