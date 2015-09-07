//
//  ProductByProductVC.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"
#import "CategoryHeaderView.h"
#import "BottomView.h"

@interface ProductByProductVC : BaseViewController<BottomViewDelegate>

@property (nonatomic, strong) NSString * shopID;
@property (nonatomic, strong) NSDictionary * categoryInfo;

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) CategoryHeaderView * categoryHeaderView;

@property (nonatomic,assign)float sendPrice;

@end
