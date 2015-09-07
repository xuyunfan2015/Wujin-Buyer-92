//
//  HistoryIndentInfo.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/14.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "HistoryIndentInfo.h"

@implementation HistoryIndentInfo

+ (instancetype)historyIndentInfoWithDictionary:(NSDictionary *)aDic {
    
    HistoryIndentInfo *_info = [[HistoryIndentInfo alloc] init];
    
    
    if (nil != aDic) {
        
        _info.name = aDic[@"name"];
        _info.money = aDic[@"money"];
        _info.number = aDic[@"number"];
        _info.ID = aDic[@"ID"];
        _info.freight = aDic[@"freight"];
        _info.isNotFreight = aDic[@"freightState"];
        _info.expressInfo = aDic[@"expressInfo"];
        
        NSMutableArray *_arr = [[NSMutableArray alloc] init];
        _info.detailArray = _arr;
    }
    
    return _info;
}
@end
