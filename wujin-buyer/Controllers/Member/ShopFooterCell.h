//
//  ShopFooterCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryIndentInfo.h"
@class  ShopFooterCell;

@protocol payClickAtSection <NSObject>

- (void)payClickAtSection:(NSInteger)section andButton:(UIButton *)aButton;

- (void)callTelephone:(NSString *)telephone;

@end

@interface ShopFooterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UIButton *refund;
@property (weak, nonatomic) IBOutlet UIButton *payment;
@property (weak, nonatomic) IBOutlet UILabel *freight;
@property (weak, nonatomic) IBOutlet UIButton *express;

@property (weak, nonatomic) IBOutlet UIImageView *downLine;
@property (weak, nonatomic) IBOutlet UIImageView *upLine;

@property NSInteger section;
@property (weak, nonatomic) id<payClickAtSection> payDelegate;

- (void)loadShopFooterCellWithIndentInfo:(HistoryIndentInfo *)aInfo;

+ (ShopFooterCell *)shopFooterCell;
@end
