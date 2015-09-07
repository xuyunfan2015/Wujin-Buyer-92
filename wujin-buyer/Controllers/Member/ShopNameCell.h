//
//  ShopNameCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//
@protocol vipPayClick;

#import <UIKit/UIKit.h>

@interface ShopNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *vip;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<vipPayClick> vipDelegate;

- (void)selectVIPPay;

- (void)cancelVIPPay;

+ (ShopNameCell *)shopNameCell;

@end

@protocol vipPayClick <NSObject>

- (void)vipPayClickWithIndexPath:(NSIndexPath *)indexPath cell:(ShopNameCell *)cell;

@end