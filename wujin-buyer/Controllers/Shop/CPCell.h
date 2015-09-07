//
//  CPCell.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPCell;

@protocol CPCellDelegate <NSObject>

- (void)cpCell:(CPCell *)cell subWithCarInfo:(NSDictionary *)carInfo;

- (void)cpCell:(CPCell *)cell addWithCarInfo:(NSDictionary *)carInfo;

@end

@interface CPCell : UITableViewCell

@property (assign, nonatomic) id<CPCellDelegate> delegate;
@property (strong,nonatomic) NSDictionary * carInfo;

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberField;

@end
