//
//  LYPasscodeDummyViewController.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYPasscodeDummyViewControllerDelegate;


@interface LYPasscodeDummyViewController : UIViewController

@property (nonatomic, weak) id<LYPasscodeDummyViewControllerDelegate> delegate;

@end


@protocol LYPasscodeDummyViewControllerDelegate <NSObject>

- (void)dummyViewControllerWillAppear:(LYPasscodeDummyViewController *)aViewController;
- (void)dummyViewControllerDidAppear:(LYPasscodeDummyViewController *)aViewController;

@end

