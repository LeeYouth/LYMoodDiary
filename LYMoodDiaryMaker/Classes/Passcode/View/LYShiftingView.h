//
//  LYShiftingView.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYShiftingDirection) {
    LYShiftingDirectionForward,
    LYShiftingDirectionBackward,
};

@interface LYShiftingView : UIView

@property (nonatomic, strong) UIView        *currentView;

- (void)showView:(UIView *)view withDirection:(LYShiftingDirection)direction;

@end
