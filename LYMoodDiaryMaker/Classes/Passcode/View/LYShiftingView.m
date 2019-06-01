//
//  LYShiftingView.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYShiftingView.h"

@implementation LYShiftingView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.currentView.frame = self.bounds;
}

- (void)setCurrentView:(UIView *)currentView
{
    if (_currentView == currentView) {
        return;
    }
    
    [_currentView removeFromSuperview];
    
    _currentView = currentView;
    
    if (currentView) {
        [self addSubview:currentView];
    }
    
    [self setNeedsLayout];
}

- (void)showView:(UIView *)view withDirection:(LYShiftingDirection)direction
{
    UIView *oldView = self.currentView;
    oldView.userInteractionEnabled = NO;
    
    CGRect nextFrame = self.bounds;
    
    switch (direction) {
        case LYShiftingDirectionForward:
            nextFrame.origin.x = CGRectGetWidth(self.bounds);
            break;
        case LYShiftingDirectionBackward:
            nextFrame.origin.x = -CGRectGetWidth(self.bounds);
            break;
    }
    
    view.frame = nextFrame;
    
    [self addSubview:view];
    
    // start animation
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        switch (direction) {
            case LYShiftingDirectionForward:
                oldView.frame = CGRectOffset(oldView.frame, -CGRectGetWidth(self.bounds), 0);
                view.frame = CGRectOffset(view.frame, -CGRectGetWidth(self.bounds), 0);
                break;
            case LYShiftingDirectionBackward:
                oldView.frame = CGRectOffset(oldView.frame, CGRectGetWidth(self.bounds), 0);
                view.frame = CGRectOffset(view.frame, CGRectGetWidth(self.bounds), 0);
                break;
        }
        
    } completion:^(BOOL finished) {
        
        [oldView removeFromSuperview];
        
    }];
    
    _currentView = view;
}

@end
