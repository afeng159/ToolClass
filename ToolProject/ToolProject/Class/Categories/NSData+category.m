//
//  NSData+category.m
//  MobileApplicationPlatform
//
//  Created by zhangdd on 15-4-23.
//  Copyright (c) 2015年 HCMAP. All rights reserved.
//

#import "NSData+category.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSData (category)
- (NSString *)MD5EncodedString
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], [self length], result);
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

@end


@implementation NSString (category)

- (NSString *)MD5EncodedString
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5EncodedString];
}
@end

