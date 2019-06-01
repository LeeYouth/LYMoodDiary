//
//  LYViewShaker.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYViewShaker.h"

static NSTimeInterval const kLYViewShakerDefaultDuration = 0.5;
static NSString * const kLYViewShakerAnimationKey = @"kLYViewShakerAnimationKey";


@interface LYViewShaker ()
@property (nonatomic, strong) NSArray * views;
@property (nonatomic, assign) NSUInteger completedAnimations;
@property (nonatomic, copy) void (^completionBlock)();
@end


@implementation LYViewShaker

- (instancetype)initWithView:(UIView *)view {
    return [self initWithViewsArray:@[ view ]];
}


- (instancetype)initWithViewsArray:(NSArray *)viewsArray {
    self = [super init];
    if ( self ) {
        self.views = viewsArray;
    }
    return self;
}


#pragma mark - Public methods

- (void)shake {
    [self shakeWithDuration:kLYViewShakerDefaultDuration completion:nil];
}


- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)())completion {
    self.completionBlock = completion;
    for (UIView * view in self.views) {
        [self addShakeAnimationForView:view withDuration:duration];
    }
}


#pragma mark - Shake Animation

- (void)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.delegate = self;
    animation.duration = duration;
    animation.values = @[ @(0), @(10), @(-8), @(8), @(-5), @(5), @(0) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:kLYViewShakerAnimationKey];
}


#pragma mark - CAAnimation Delegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    self.completedAnimations += 1;
    if ( self.completedAnimations >= self.views.count ) {
        self.completedAnimations = 0;
        if ( self.completionBlock ) {
            self.completionBlock();
        }
    }
}


@end

