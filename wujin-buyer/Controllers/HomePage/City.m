//
//  City.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/18.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "City.h"

@implementation City

+ cityWithDiction:(NSDictionary *)dic andLevel:(kLocationLevel)lev {
    City *_city = [[City alloc] init];
    
    if (nil != dic) {
        
        _city.name = dic[@"name"];
        _city.ID = dic[@"ID"];
        
        _city.level =  lev;
        
        NSMutableArray *array = [NSMutableArray array];
        _city.cities = array;
    }
    
    return _city;
}
@end
