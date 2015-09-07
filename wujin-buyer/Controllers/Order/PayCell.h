//
//  PayCell.h
//  wujin-buyer
//
//  Created by jensen on 15/6/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *deleverLabel;

@property (weak, nonatomic) IBOutlet UILabel *yhPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *souldPayLabel;

@end
