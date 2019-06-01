//
//  LYTouchIDManager.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/6/1.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYTouchIDManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

static NSString *const LYTouchIDManagerPasscodeAccountName = @"passcode";
static NSString *const LYTouchIDManagerTouchIDEnabledAccountName = @"enabled";

@interface LYTouchIDManager () {
    dispatch_queue_t _queue;
}

@property (nonatomic, strong) NSString                  *keychainServiceName;

@end

@implementation LYTouchIDManager

- (instancetype)initWithKeychainServiceName:(NSString *)serviceName
{
    self = [super init];
    if (self) {
        
        _queue = dispatch_queue_create("LYTouchIDManagerQueue", DISPATCH_QUEUE_SERIAL);
        
        NSParameterAssert(serviceName);
        
        self.keychainServiceName = serviceName;
    }
    return self;
}

+ (BOOL)canUseTouchID
{
    if (![LAContext class]) {
        return NO;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    BOOL result = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    return result;
}

- (void)savePasscode:(NSString *)passcode completionBlock:(void(^)(BOOL success))completionBlock
{
    NSParameterAssert(passcode);
    
    if (NO == [[self class] canUseTouchID]) {
        if (completionBlock) {
            completionBlock(NO);
        }
        return;
    }
    
    NSString *serviceName = self.keychainServiceName;
    NSData *passcodeData = [passcode dataUsingEncoding:NSUTF8StringEncoding];
    
    dispatch_async(_queue, ^{
        
        BOOL success = [[self class] saveKeychainItemWithServiceName:serviceName
                                                         accountName:LYTouchIDManagerPasscodeAccountName
                                                                data:passcodeData
                                                            sacFlags:kSecAccessControlUserPresence];
        
        if (success) {
            
            BOOL enabled = YES;
            
            success = [[self class] saveKeychainItemWithServiceName:serviceName
                                                        accountName:LYTouchIDManagerTouchIDEnabledAccountName
                                                               data:[NSData dataWithBytes:&enabled length:sizeof(BOOL)]
                                                           sacFlags:0];
        }
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(success);
            });
        }
    });
}

- (void)loadPasscodeWithCompletionBlock:(void (^)(NSString *))completionBlock
{
    if (NO == [[self class] canUseTouchID]) {
        if (completionBlock) {
            completionBlock(nil);
        }
        return;
    }
    
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithDictionary:@{ (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                                                                  (__bridge id)kSecAttrService: self.keychainServiceName,
                                                                                  (__bridge id)kSecAttrAccount: LYTouchIDManagerPasscodeAccountName,
                                                                                  (__bridge id)kSecReturnData: @YES }];
    
    if (self.promptText) {
        query[(__bridge id)kSecUseOperationPrompt] = self.promptText;
    }
    
    dispatch_async(_queue, ^{
        
        CFTypeRef dataTypeRef = NULL;
        
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), &dataTypeRef);
        
        NSString *result = nil;
        
        if (status == errSecSuccess) {
            
            NSData *resultData = ( __bridge_transfer NSData *)dataTypeRef;
            result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        }
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(result);
            });
        }
    });
}

- (void)deletePasscodeWithCompletionBlock:(void (^)(BOOL))completionBlock
{
    dispatch_async(_queue, ^{
        
        BOOL success = ([[self class] deleteKeychainItemWithServiceName:self.keychainServiceName accountName:LYTouchIDManagerPasscodeAccountName] &&
                        [[self class] deleteKeychainItemWithServiceName:self.keychainServiceName accountName:LYTouchIDManagerTouchIDEnabledAccountName]);
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(success);
            });
        }
    });
}

- (BOOL)isTouchIDEnabled
{
    NSDictionary *query = @{ (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                             (__bridge id)kSecAttrService: self.keychainServiceName,
                             (__bridge id)kSecAttrAccount: LYTouchIDManagerTouchIDEnabledAccountName,
                             (__bridge id)kSecReturnData: @YES };
    
    CFTypeRef dataTypeRef = NULL;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), &dataTypeRef);
    
    if (status == errSecSuccess) {
        
        NSData *resultData = ( __bridge_transfer NSData *)dataTypeRef;
        BOOL result;
        [resultData getBytes:&result length:sizeof(BOOL)];
        
        return result;
        
    } else {
        return NO;
    }
}

#pragma mark - Static Methods

+ (BOOL)saveKeychainItemWithServiceName:(NSString *)serviceName accountName:(NSString *)accountName data:(NSData *)data sacFlags:(SecAccessControlCreateFlags)sacFlags
{
    // try to update first
    BOOL success = [self updateKeychainItemWithServiceName:serviceName accountName:accountName data:data];
    
    if (success) {
        return YES;
    }
    
    // try deleting when update failed (workaround for iOS 8 bug)
    [self deleteKeychainItemWithServiceName:serviceName accountName:accountName];
    
    // try add
    return [self addKeychainItemWithServiceName:serviceName accountName:accountName data:data sacFlags:sacFlags];
}

+ (BOOL)addKeychainItemWithServiceName:(NSString *)serviceName accountName:(NSString *)accountName data:(NSData *)data sacFlags:(SecAccessControlCreateFlags)sacFlags
{
    CFErrorRef error = NULL;
    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                                    kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                    sacFlags, &error);
    
    if (sacObject == NULL || error != NULL) {
        return NO;
    }
    
    NSDictionary *attributes = @{ (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                  (__bridge id)kSecAttrService: serviceName,
                                  (__bridge id)kSecAttrAccount: accountName,
                                  (__bridge id)kSecValueData: data,
                                  (__bridge id)kSecUseNoAuthenticationUI: @YES,
                                  (__bridge id)kSecAttrAccessControl: (__bridge_transfer id)sacObject };
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, nil);
    
    return (status == errSecSuccess);
}

+ (BOOL)updateKeychainItemWithServiceName:(NSString *)serviceName accountName:(NSString *)accountName data:(NSData *)data
{
    NSDictionary *query = @{ (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                             (__bridge id)kSecAttrService: serviceName,
                             (__bridge id)kSecAttrAccount: accountName };
    
    NSDictionary *changes = @{ (__bridge id)kSecValueData: data };
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)changes);
    
    return (status == errSecSuccess);
}

+ (BOOL)deleteKeychainItemWithServiceName:(NSString *)serviceName accountName:(NSString *)accountName
{
    NSDictionary *query = @{ (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                             (__bridge id)kSecAttrService: serviceName,
                             (__bridge id)kSecAttrAccount: accountName };
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)(query));
    
    return (status == errSecSuccess || status == errSecItemNotFound);
}

+ (void)initTouchIDWithMessage:(NSString *)message
                    completion:(void(^)(BOOL prompted))aCompletionBlock{
    LAContext *context = [[LAContext alloc]init];
    context.localizedFallbackTitle = LY_LocalizedString(@"kLYCantUserTouchID");
    
    NSError *error = nil;

    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        //用于设置提示语，表示为什么要使用Touch ID，如代码中@"您是这设备的所有者吗？"。
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message.length?message: LY_LocalizedString(@"kLYUseTouchIDToHome") reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                if (aCompletionBlock) {
                    aCompletionBlock(YES);
                }
                
            } else if (error) {
                if (aCompletionBlock) {
                    aCompletionBlock(NO);
                }
                
                switch (error.code)
                {
                        // 用户未提供有效证书,(3次机会失败 --身份验证失败)。
                    case LAErrorAuthenticationFailed:
                    {
                        
                    }
                        break;
                        
                    case LAErrorUserCancel:
                    {
                        // 认证被取消,(用户点击取消按钮)。
                    }
                        break;
                        
                    case LAErrorUserFallback:
                    {
                        //用户选择“手势验证”，切换主线程处理
                    }
                        break;
                        
                    case LAErrorSystemCancel:
                    {
                        //在这种情况下，系统终止验证处理，因为另一个应用被激活了。
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet:
                    {
                        // 身份验证无法启动,因为密码在设备上没有设置。
                    }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled:
                    {
                        //设备Touch ID不可用，用户未录入(在5s 上没有设置指纹密码时)
                    }
                        break;
                        
                        
                        
                    case LAErrorTouchIDNotAvailable:
                    {
                        //设备Touch ID不可用，例如未打开
                    }
                        break;
                        
                    case LAErrorTouchIDLockout:
                    {
                        //多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
                    }
                        break;
                        
                    case LAErrorAppCancel:
                    {
                        //当前软件被挂起取消了授权(如突然来了电话,应用进入前台)

                    }
                        break;
                        
                    case LAErrorInvalidContext:
                    {
                        
                    }
                        break;
                }
            }
        }];
        
    } else {
        if (aCompletionBlock) {
            aCompletionBlock(NO);
        }
        
    }
}

@end

