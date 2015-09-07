//
//  CollectProductInfo.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CollectProductInfo.h"

@implementation CollectProductInfo

+ (instancetype)collectProductInfoWithDictionary:(NSDictionary *)aDic {
    CollectProductInfo *_info = [[CollectProductInfo alloc] init];
        
    _info.collectProductImage = aDic[@"image"];
    _info.collectProductName = aDic[@"name"];
    _info.collectProductPrice = aDic[@"price"];
    _info.ID = aDic[@"ID"];
    
    return _info;
}
@end
