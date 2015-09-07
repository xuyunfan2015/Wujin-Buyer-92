//
//  CollectShopInfo.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectShopInfo : NSObject

@property (strong, nonatomic) NSString *collectShopImage;
@property (strong, nonatomic) NSString *collectShopName;
@property (strong, nonatomic) NSString *collectShopTelephone;
@property (strong, nonatomic) NSString *mainBusiness;
@property (strong, nonatomic) NSString *ID;

+ (instancetype)collectShopInfoWithDictionary:(NSDictionary *)aDic;
@end
