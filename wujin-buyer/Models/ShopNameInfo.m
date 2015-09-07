//
//  ShopNameInfo.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopNameInfo.h"

@implementation ShopNameInfo

+ (instancetype)shopNameInfoWithDictionary:(NSDictionary *)aDic {
    
    ShopNameInfo *_info = [[ShopNameInfo alloc] init];
    
    if (nil != aDic) {
        
        _info.name = aDic[@"name"];
        _info.VIPPay = aDic[@"VIP"];
        _info.ID = aDic[@"ID"];
        _info.telephone = aDic[@"telephone"];
        _info.shipmentsState = aDic[@"shipmentsState"];
        
        if (YES == [aDic[@"vipPay"] boolValue]) {
            
            _info.isVipPay = YES;
        } else {
            
            _info.isVipPay = NO;
        }
    }
    
    return _info;
}

@end
