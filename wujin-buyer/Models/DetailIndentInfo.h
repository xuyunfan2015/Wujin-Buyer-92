//
//  DetailIndentInfo.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NORMAL @"确认收货"
#define REFUND @"退款中..."
#define SELLER_REFUND @"确认退款"
#define DID_REFUND @"已退款"

@interface DetailIndentInfo : NSObject

@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *detailID;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *message;

+ (instancetype)detailIndentInfo:(NSDictionary *)aDic;
@end
