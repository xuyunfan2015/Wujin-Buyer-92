//
//  HistoryIndentInfo.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/14.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopNameInfo.h"

@interface HistoryIndentInfo : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *expressInfo;

@property (strong, nonatomic) NSString *freight;
@property (strong, nonatomic) NSString *isNotFreight;

@property (strong, nonatomic) NSMutableArray *detailArray;

+ (instancetype)historyIndentInfoWithDictionary:(NSDictionary *)aDic;
@end
