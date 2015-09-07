//
//  OrderCarCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WTURLImageView.h"

@class OrderCarCell;

@protocol OrderCarCellDelegate <NSObject>

- (void)orderCarCell:(OrderCarCell *)orderCarCell subAtIndex:(int)index;
- (void)orderCarCell:(OrderCarCell *)orderCarCell addAtIndex:(int)index;

@end

@interface OrderCarCell : UITableViewCell

@property (assign, nonatomic) id<OrderCarCellDelegate> delegate;

@property (assign, nonatomic)int index;

@property (weak, nonatomic) IBOutlet UILabel *mNumberLabel;

////////添加数量/////////////
@property (weak, nonatomic) IBOutlet UILabel *nLabel;

//@property (weak, nonatomic) IBOutlet UILabel *tempField;

@property (weak, nonatomic) IBOutlet WTURLImageView *productIcon;

@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@property (weak, nonatomic) IBOutlet UILabel *productNumbers;

@property (weak, nonatomic) IBOutlet UILabel *createLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UILabel *shopAddress;

@end
