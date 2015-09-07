//
//  PositionViewController.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#define GPS @"GPS定位"


@protocol selectAddressDelegate <NSObject>

- (void)selectAddress:(NSString *)city;

@end

#import "BaseViewController.h"

@interface PositionViewController : BaseViewController

@property (weak, nonatomic) id<selectAddressDelegate> cityDelegate;

@end
