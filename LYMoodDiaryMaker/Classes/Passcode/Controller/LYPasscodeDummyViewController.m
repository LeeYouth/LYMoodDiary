//
//  LYPasscodeDummyViewController.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYPasscodeDummyViewController.h"

@interface LYPasscodeDummyViewController ()

@end

@implementation LYPasscodeDummyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.delegate dummyViewControllerWillAppear:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.presentedViewController == nil) {
        // only calls delegate when presented view controller(modal view controller) does not exists.
        [self.delegate dummyViewControllerDidAppear:self];
    }
}

@end
