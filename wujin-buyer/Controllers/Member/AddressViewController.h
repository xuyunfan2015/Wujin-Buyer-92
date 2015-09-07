//
//  AddressViewController.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/7.
//  Copyright (c) 2015年 wujin. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class AddressInfo;

@protocol selectAddressDelegate <NSObject>

@optional

- (void)selectAddressWithAddressInfo:(AddressInfo *)aInfo;

@end

@interface AddressViewController : BaseViewController

@property (strong, nonatomic) id<selectAddressDelegate> seclectDelegate;

@property BOOL isSelected;

@end
