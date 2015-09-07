//
//  AddressList.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/9.
//  Copyright (c) 2015年 wujin. All rights reserved.
//
typedef NS_ENUM(NSInteger, kSendToServerType) {
    
    kSendToServerAdd = 0,
    kSendToServerDelegate,
    kSendToServerModification
};


#import <Foundation/Foundation.h>


@interface AddressList : NSObject

@property (strong, atomic) NSString *name;
@property (strong, atomic) NSString *telephone;
@property (strong, atomic) NSString *address;
@property (strong, atomic) NSString *detailAddress;
@property (strong, atomic) NSString *posecode;

/**
 获取用户ID的收货地址列表
 */
+ (instancetype)addressListWithDictionary:(NSDictionary *)aDic;

/**
 以kSendToServerType标示是修改，增加，删除
 */
- (BOOL)sendToServer:(kSendToServerType)type;
@end
