//
//  ShopView.h
//  wujin-buyer
//
//  Created by jensen on 15/6/28.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@class ShopView;

@protocol ShopViewDelegate <NSObject>

- (void)shopView:(ShopView *)shopView didGotoShop:(NSDictionary *)shopInfo;

@end


@interface ShopView : UIView

@property (assign, nonatomic) id<ShopViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet WTURLImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel * addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneField;

@property (assign, nonatomic) NSDictionary * shopInfo;

- (void)openWithShopInfo:(NSDictionary *)productInfo inSuperView:(UIView *)superView;

@end
