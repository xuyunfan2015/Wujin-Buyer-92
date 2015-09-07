//
//  ShopNameInfo.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailIndentInfo.h"

@interface ShopNameInfo : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *shipmentsState;

@property (strong, nonatomic) NSString *VIPPay;
@property BOOL isVipPay;

+ (instancetype)shopNameInfoWithDictionary:(NSDictionary *)aDic;
@end
