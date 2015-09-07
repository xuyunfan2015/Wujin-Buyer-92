//
//  CollectShopInfo.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CollectShopInfo.h"

@implementation CollectShopInfo

+ (instancetype)collectShopInfoWithDictionary:(NSDictionary *)aDic {
    CollectShopInfo *_info = [[CollectShopInfo alloc] init];

        
    _info.collectShopImage = aDic[@"image"];
    _info.collectShopName = aDic[@"name"];
    _info.collectShopTelephone = aDic[@"telephone"];
    _info.mainBusiness = aDic[@"business"];
    _info.ID = aDic[@"ID"];

    return _info;
}
@end
