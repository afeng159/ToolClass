//
//  NSData+category.h
//  MobileApplicationPlatform
//
//  Created by zhangdd on 15-4-23.
//  Copyright (c) 2015年 HCMAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (category)
- (NSString *)MD5EncodedString;
@end

@interface NSString (RCMEncryptMD5)
- (NSString *)MD5EncodedString;
@end
