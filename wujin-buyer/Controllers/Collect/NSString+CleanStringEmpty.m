//
//  UIImageView+CleanStringEmpty.m
//  wujin-buyer
//
//  Created by wujin  on 15/2/2.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "NSString+CleanStringEmpty.h"

@implementation NSString (CleanStringEmpty)

- (NSString *)cleanStringEmpty {
    
    NSMutableString *myStr = [NSMutableString stringWithString:self];
    
    return [myStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
