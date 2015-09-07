//
//  WJKeychain.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/19.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY_USERNAME_PASSWORD @"com.wujin-buyer.app.usernamepassword"
#define KEY_USERNAME @"com.wujin-buyer.app.username"
#define KEY_PASSWORD @"com.wujin-buyer.app.password"

@interface WJKeychain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)delete:(NSString *)service;

+ (id)load:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

@end
