//
//  ShopViewController.h
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
/*
 问题
 1.购物车在ios8以下不能选中
 2.店铺详情的收藏按钮不能点击
 */
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ShopViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString * searchName;

@property (strong, nonatomic) NSString *marketId;

@property (strong, nonatomic) NSMutableArray * productArray;//

@property (weak, nonatomic) IBOutlet UICollectionView *productCollectView;

@property BOOL isFromMarket;

@end
