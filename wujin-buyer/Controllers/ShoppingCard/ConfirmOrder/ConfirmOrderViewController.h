//
//  ConfirmOrderViewController.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"

@interface ConfirmOrderViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray* shopArrays;//所有商品

@property (weak, nonatomic) IBOutlet UILabel * freightLabel;

@property (weak, nonatomic) IBOutlet UILabel * totalPriceLabel;
@property (strong,nonatomic) NSString *shopid;
@end
