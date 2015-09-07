//
//  AddressList.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/9.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AddressInfo.h"

@implementation AddressInfo

+ (instancetype)addressInfoWithDictionary:(NSDictionary *)aDic {
    
    AddressInfo *_info = [[AddressInfo alloc] init];
    
    _info.name = aDic[@"name"];
    _info.telephone = aDic[@"phone"];
    _info.address = aDic[@"qid"];
    _info.detailAddress = aDic[@"address"];
    _info.ID = aDic[@"id"];
    _info.isDefault = aDic[@"isdefault"];
    
    return _info;
}

+ (instancetype)addressInfoAtOrderWithDictionary:(NSDictionary *)aDic {
    
    AddressInfo *_info = [[AddressInfo alloc] init];
    
    _info.name = aDic[@"name"];
    _info.telephone = aDic[@"phone"];
    _info.address = aDic[@"qid"];
    _info.detailAddress = aDic[@"address"];
    _info.ID = aDic[@"id"];
    _info.isDefault = aDic[@"isdefault"];
    
    return _info;
}

@end
