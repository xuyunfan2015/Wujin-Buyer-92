//
//  NSString+base64.m
//  wujin-buyer
//
//  Created by wujin on 15/1/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "NSString+base64.h"

@implementation NSString (base64)

- (NSString *)base64Encrypt {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    return base64String;
}
@end
