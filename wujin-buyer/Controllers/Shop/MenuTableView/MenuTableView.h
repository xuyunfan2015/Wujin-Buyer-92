//
//  MenuTableView.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/21.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"

@class MenuTableView;

@protocol MenuTableViewDelegate <NSObject>


///市场展示
- (UIView *)tableView:(MenuTableView *)tableView viewForRootHeaderInSection:(NSInteger)section;   //市场header的布局
- (CGFloat)tableView:(MenuTableView *)tableView heightForRootHeaderInSection:(NSInteger)section;//市场header的高度
- (NSInteger)numberOfRootSections;//市场的个数

- (NSInteger)numberOfShopAndProductInSection:(NSInteger)section;

//////店铺展示
- (UITableViewCell *)tableView:(MenuTableView *)tableView cellForShopRowAtIndexPath:(NSIndexPath *)indexPath;/// index  section 0
//店铺点击
- (void)tableView:(MenuTableView *)tableView didSelectShopAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(MenuTableView *)tableView heightForShopRowAtIndexPath:(NSIndexPath *)indexPath;//看section

///商品展示

- (CGFloat)tableView:(MenuTableView *)tableView heightForAllProductsRowAtIndexPath:(NSIndexPath *)indexPath;//高度

//商定有多少个产品
- (NSInteger)numberOfProductsAtShop:(NSInteger)shopIndex marketIndex:(NSInteger)marketIndex;//

- (NSInteger)numberOfCategorysAtProduct:(NSInteger)productIndex shopIndex:(NSInteger)shopIndex marketIndex:(NSInteger)marketIndex;

- (CGFloat)tableView:(UITableView *)tableView heightForCaregoryRowAtIndexPath:(NSIndexPath *)indexPath shopIndex:(NSInteger)shopIndex marketIndex:(NSInteger)marketIndex;//看section

- (UITableViewCell *)tableView:(UITableView *)tableView cellForCategoryRowAtIndexPath:(NSIndexPath *)indexPath shopIndex:(NSInteger)shopIndex marketIndex:(NSInteger)marketIndex;

//商品点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath shopIndex:(NSInteger)shopIndex marketIndex:(NSInteger)marketIndex;

@end

@interface MenuTableView : UIView<MenuTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign,nonatomic)id<MenuTableViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)layoutMenuTableView;

- (void)reloadMenuData;

- (void)reloadMenuSections:(NSIndexSet *)indexSet;

@end
