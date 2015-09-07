//
//  AddressList.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/9.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AddressList.h"

@implementation AddressList

+ (instancetype)addressListWithDictionary:(NSDictionary *)aDic {
    
    AddressList *_list = [[AddressList alloc] init];
    
    _list.name = @"爱在西元前";
    _list.telephone = @"13789199901";
    _list.address = @"爱好的";
    _list.posecode = @"422100";
    _list.detailAddress = @"爱好的健康和顾客航空爱好";
    
    return _list;
}

- (BOOL)sendToServer:(kSendToServerType)type {
    
    return YES;
}
@end
