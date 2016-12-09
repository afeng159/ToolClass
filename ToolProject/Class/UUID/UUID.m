//
//  UUID.m
//  ieme
//
//  Created by 啦啦啦 on 16/6/16.
//  Copyright © 2016年 啦啦啦. All rights reserved.
//

#import "UUID.h"
#import <UIKit/UIKit.h>
#import <Security/Security.h>
@implementation UUID 
static NSString *kServiceName = @"YOUR_APP_BundleIdentifier";
static NSString *kUUIDKeychainIdentify = @"UUID";

+(NSString *)getUUID{
    NSString *uuid = [self searchKeychainCopyMatching:kUUIDKeychainIdentify];
    if (!uuid) {
        uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [self createKeychainValue:uuid forIdentifier:kUUIDKeychainIdentify];
    }
    return uuid;
}

+ (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrAccount];
    [searchDictionary setObject:kServiceName forKey:(id)kSecAttrService];
    
    return searchDictionary;
}
//读取存储在Keychain的值
+ (NSString *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    
    // Add search attributes
    [searchDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    
    CFTypeRef result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)searchDictionary,
                                          &result);
    if (status != noErr) {
        NSLog(@"keychain读取失败");
    }else{
        NSLog(@"keychain读取成功");
    }
    NSData *uuidData = (__bridge NSData *)result;
    NSString *uuid = nil;
    if (uuidData) {
        uuid = [[NSString alloc] initWithData:uuidData
                                     encoding:NSUTF8StringEncoding];
    }
    return uuid;
}
//添加
+ (BOOL)createKeychainValue:(NSString *)uuid forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    
    NSData *uuidData = [uuid dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:uuidData forKey:(id)kSecValueData];
    
    OSStatus status = SecItemAdd((CFDictionaryRef)dictionary, NULL);
    
    if (status == errSecSuccess) {
        NSLog(@"keychen保存成功");
        return YES;
    }
    NSLog(@"keychen保存失败");
    return NO;
}
//更新
+ (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(id)kSecValueData];
    
    OSStatus status = SecItemUpdate((CFDictionaryRef)searchDictionary,
                                    (CFDictionaryRef)updateDictionary);
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}
//删除
+ (void)deleteKeychainValue:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    SecItemDelete((CFDictionaryRef)searchDictionary);
}
//调用+(NSString *)getUUID方法就可以实现keychain中读取UUID了；
//每个应用只能读取该应用保存在keychain中的数据，貌似同一个账号下的app可以互相读取数据，这个以后再研究。
@end
