//
//  ShowDetailViewController.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"
#import "HomePageDetailList.h"


@interface ShowDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UICollectionView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic,assign) BOOL isFromMap;
@property (nonatomic, strong) NSString * shopID;/////店铺ID
@property (nonatomic,strong) HomePageDetailList * cShopInfo;//商品信息
//////////////////////////////
@property (nonatomic,assign) int category;
/////0.店铺详情 (需要传递shopID)
//// 1.产品分类跳转过来(需要传递 shopID以及categoryid)
@property (nonatomic,strong) NSString * categoryID;

@property (nonatomic, strong) NSString * keyName;



@end
