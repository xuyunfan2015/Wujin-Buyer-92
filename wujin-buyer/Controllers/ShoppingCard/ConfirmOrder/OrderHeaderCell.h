//
//  OrderHeaderCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderHeaderCell;

@protocol OrderHeaderCellDelegate <NSObject>

- (void)orderHeaderCell:(OrderHeaderCell *)orderHeaderCell selectVip:(BOOL)isVip;

- (void)orderHeaderCell:(OrderHeaderCell *)orderHeaderCell didClickTel:(NSString *)tel;

- (void)orderHeaderCellDidClickMsg:(OrderHeaderCell *)orderHeaderCell;

@end

@interface OrderHeaderCell : UITableViewCell

@property (assign, nonatomic)id<OrderHeaderCellDelegate> delegate;

@property (assign, nonatomic) NSInteger shopIndex;
@property (strong,nonatomic) NSDictionary * shopDic;

@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIButton *isVipButton;

@property (weak, nonatomic) IBOutlet UIButton *telButton;

@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@end
