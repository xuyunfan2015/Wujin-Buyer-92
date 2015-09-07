//
//  NSObject+MD5.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "NSString+MD5.h"
#import "CommonCrypto/CommonDigest.h"


@implementation NSString (MD5)

- (NSString *)MD5Encrypt {
    
    const char *cStr = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        
        [ret appendFormat:@"%02x", result[i]];
    }
    
    return ret;
}
@end
