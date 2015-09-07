//
//  ShowHeaderView.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"
#import "HomePageDetailList.h"

@protocol ShopHeaderDelegate <NSObject>

- (void)collectClick;

@end

@interface ShopHeaderView : UIView

@property (strong, nonatomic)HomePageDetailList * homePageList;


@property (weak, nonatomic) IBOutlet UIImageView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *shfwLabel;

@property (weak, nonatomic) IBOutlet UILabel *swjgLabel;

///代理
@property (assign,nonatomic) id<ShopHeaderDelegate> delegate;

- (void)layoutWithShopInfo:(HomePageDetailList *)shopInfo;

@end
