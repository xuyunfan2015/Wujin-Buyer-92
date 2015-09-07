//
//  ShopWebViewController.h
//  wujin-buyer
//
//  Created by Alan on 15/8/22.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"
#import "HomePageDetailList.h"
@interface ShopWebViewController : BaseViewController

@property (nonatomic, strong) NSString * shopID;/////店铺ID
@property (nonatomic,strong) HomePageDetailList * cShopInfo;//商品信息
@end
