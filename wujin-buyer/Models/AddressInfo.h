//
//  AddressList.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/9.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AddressInfo : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *detailAddress;
@property (strong, nonatomic) NSString *postcode;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *isDefault;

/**
 获取用户ID的收货地址列表
 */
+ (instancetype)addressInfoWithDictionary:(NSDictionary *)aDic;

+ (instancetype)addressInfoAtOrderWithDictionary:(NSDictionary *)aDic;

@end
