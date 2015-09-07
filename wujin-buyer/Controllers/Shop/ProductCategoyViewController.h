//
//  ProductCategoyViewController.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"

@interface ProductCategoyViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString * shopID;

@end
