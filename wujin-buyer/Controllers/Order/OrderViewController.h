//
//  OrderViewController.h
//  wujin-buyer
//
//  Created by jensen on 15/6/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailViewController.h"

@interface OrderViewController : BaseViewController

@property(assign, nonatomic) int type;//0.所有  1.代付款  2.已发货  3.完成交易

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic)BOOL isFrom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraint;

@end
