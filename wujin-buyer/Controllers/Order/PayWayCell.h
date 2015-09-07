//
//  PayWayCell.h
//  wujin-buyer
//
//  Created by jensen on 15/6/28.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PayWayCell;

@protocol PayWayCellDelegate <NSObject>

- (void)paywayCell:(PayWayCell *)paywayCell didSelectedAtIndex:(int)index;

@end

@interface PayWayCell : UITableViewCell

@property (assign, nonatomic) id<PayWayCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *payName;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (assign, nonatomic)int index;

@end
