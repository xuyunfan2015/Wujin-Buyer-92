//
//  DetailIndentInfo.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "DetailIndentInfo.h"

@implementation DetailIndentInfo

+ (instancetype)detailIndentInfo:(NSDictionary *)aDic {
    DetailIndentInfo *_info = [[DetailIndentInfo alloc] init];
    
    if (nil != aDic) {
        
        _info.name = aDic[@"name"];
        _info.image = aDic[@"image"];
        _info.category = [NSString stringWithFormat:@"规格:%@", aDic[@"category"]];
        _info.money = aDic[@"price"];
        _info.number = aDic[@"number"];
        _info.ID = aDic[@"ID"];
        _info.detailID = aDic[@"productDetailID"];
        _info.state = aDic[@"state"];
        
        switch ([_info.state intValue]) {
            case 0:
                _info.message = NORMAL;
                break;
                
            case 1:
                _info.message = REFUND;
                break;
                
            case 2:
                _info.message = SELLER_REFUND;
                break;
                
            case 3:
                _info.message = DID_REFUND;
                break;
        }
    }
    
    return _info;
}
@end
