//
//  CheckOrderViewController.h
//  wujin-buyer
//
//  Created by jensen on 15/6/28.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckOrderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign) float totalMoney;
@property(nonatomic,assign)NSString *productName;
@property(nonatomic,assign)NSArray *productdetail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
