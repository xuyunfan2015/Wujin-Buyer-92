//
//  HomePageDetailInfo.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HomePageDetailList : NSObject

@property (strong, nonatomic) NSString *shopImage;
@property (strong, nonatomic) NSString *shopName;
@property (strong, nonatomic) NSString *shopAddress;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *distance;

@property (strong, nonatomic) NSString * sscore;//送货范围
@property (strong, nonatomic) NSString * sjyfw;//经营范围
@property (strong, nonatomic) NSString * sfprice; //起送价
@property (strong, nonatomic) NSString * smobile;//联系电话
@property (strong,nonatomic) NSString  * statetime;//开店时间
@property (strong,nonatomic) NSString * endtime;

@property (strong,nonatomic)NSString *shanc;
@property (strong,nonatomic)NSString *age;
@property (strong,nonatomic)NSString *cage;
@property (strong,nonatomic)NSString *srema;//宣言
@property (strong,nonatomic)NSString *saddress;
@property (strong,nonatomic)NSString *introduction;
+ (instancetype)homePageDetailListWithDictionary:(NSDictionary *)shopInfo;
@end
