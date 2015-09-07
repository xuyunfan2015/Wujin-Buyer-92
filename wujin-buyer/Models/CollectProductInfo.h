//
//  CollectProductInfo.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectProductInfo : NSObject

@property (strong, nonatomic) NSString *collectProductImage;
@property (strong, nonatomic) NSString *collectProductName;
@property (strong, nonatomic) NSString *collectProductPrice;
@property (strong, nonatomic) NSString *ID;

+ (instancetype)collectProductInfoWithDictionary:(NSDictionary *)aDic;
@end
