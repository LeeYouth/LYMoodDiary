//
//  LYTouchIDManager.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTouchIDManager : NSObject

@property (nonatomic, strong, readonly) NSString                *keychainServiceName;
@property (nonatomic, strong) NSString                          *promptText;
@property (nonatomic, readonly, getter=isTouchIDEnabled) BOOL   touchIDEnabled;

+ (BOOL)canUseTouchID;

- (instancetype)initWithKeychainServiceName:(NSString *)serviceName;

- (void)savePasscode:(NSString *)passcode completionBlock:(void(^)(BOOL success))completionBlock;

- (void)loadPasscodeWithCompletionBlock:(void(^)(NSString *passcode))completionBlock;

- (void)deletePasscodeWithCompletionBlock:(void(^)(BOOL success))completionBlock;

+ (void)initTouchIDWithMessage:(NSString *)message
                    completion:(void(^)(BOOL prompted))aCompletionBlock;
@end
