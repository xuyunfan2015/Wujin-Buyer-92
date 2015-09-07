//
//  City.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/18.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kLocationLevel) {
    kLocationLevelOne = 1,
    kLocationLevelTwo,
    kLocationLevelThree
};

@interface City : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ID;
@property kLocationLevel level;

@property (strong, nonatomic) NSMutableArray *cities;

+ cityWithDiction:(NSDictionary *)dic andLevel:(kLocationLevel)lev;
@end
