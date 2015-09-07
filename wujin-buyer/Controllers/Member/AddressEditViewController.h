//
//  AddressEditViewController.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/9.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

@class AddressInfo;
@protocol AddressEditState;

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, kAddressState) {
    kAddressStateAdd,//增加
    kAddressStateSub,//删除
    kAddressStateDef, //设置默认
    kAddressStateAlt
};


@interface AddressEditViewController : BaseViewController
@property (strong, nonatomic) id <AddressEditState> addressDelegate;

@property (strong, nonatomic) AddressInfo *addressInfo;

@property (weak, nonatomic) IBOutlet UIButton *setDefaults;


@end

@protocol AddressEditState <NSObject>

- (void)addressEditState:(kAddressState)state andInfo:(AddressInfo *)aInfo;

@end