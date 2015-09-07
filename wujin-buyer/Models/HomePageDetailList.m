//
//  HomePageDetailInfo.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "HomePageDetailList.h"
#import "AppUtil.h"

@implementation HomePageDetailList

+ (instancetype)homePageDetailListWithDictionary:(NSDictionary *)shopInfo {
    HomePageDetailList *_list = [[HomePageDetailList alloc] init];

    _list.shopImage = shopInfo[@"simg"];
    _list.shopName = shopInfo[@"sname"];
    _list.shopAddress = shopInfo[@"saddress"];
    _list.ID = shopInfo[@"sid"];
    _list.distance = shopInfo[@"shopjl"];
    
    
    _list.sscore = shopInfo[@"sscore"];
    _list.sjyfw = shopInfo[@"sjyfw"];
    _list.sfprice = shopInfo[@"sfprice"];
    _list.smobile = shopInfo[@"smobile"];
    _list.statetime = shopInfo[@"statetime"];
    _list.endtime = shopInfo[@"endtime"];
    _list.shanc=shopInfo[@"shanc"];
    _list.age=shopInfo[@"age"];
    _list.cage=shopInfo[@"cage"];
    _list.srema=shopInfo[@"srema"];
    _list.saddress=shopInfo[@"saddress"];
    _list.introduction=shopInfo[@"introduction"];
   
    return _list;
}
@end
