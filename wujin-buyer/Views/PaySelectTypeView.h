//
//  PaySelectTypeView.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/23.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

typedef NS_ENUM(NSInteger, kPaySelectType) {
    kPaySelectAlipayApp = 1,
    kPaySelectAlipayWeb,
    kPaySelectWechatApp,
    kPaySelectWechatPub,
    kPaySelectUnionpayPhone,
    kPaySelectUnionpayWeb
};

@protocol PaySelectTypeDelegate <NSObject>

@optional

- (void)PaySelect:(UIView *)payView Type:(kPaySelectType)payType;

@end

#import <UIKit/UIKit.h>

@interface PaySelectTypeView : UIView

@property (weak, nonatomic) id<PaySelectTypeDelegate> payDelegate;

@end
