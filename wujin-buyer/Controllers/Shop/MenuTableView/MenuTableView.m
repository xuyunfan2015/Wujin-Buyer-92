//
//  MenuTableView.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/21.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "MenuTableView.h"

@implementation MenuTableView

- (void)layoutMenuTableView {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[self getNibByIdentifity:@"MenuTableViewCell"] forCellReuseIdentifier:@"MenuTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delaysContentTouches = NO;
    self.tableView.backgroundColor = CLEAR_COLOR;
    
    self.userInteractionEnabled = YES;
}

     
#pragma mark - Util
     
- (UINib *)getNibByIdentifity:(NSString *)identifity {
         
    UINib * cellNib = [UINib nibWithNibName:identifity bundle:nil];
         
    return cellNib;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

//////市场展示

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { ///共有多少个市场
    
    return [self.delegate numberOfRootSections];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [self.delegate tableView:self viewForRootHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [self.delegate tableView:self heightForRootHeaderInSection:section];
}


////////商店展示

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.delegate numberOfShopAndProductInSection:(NSInteger)section]; //店铺名称名称 + 店铺的产品列表产品列表

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) { //商店布局
        
        [self.delegate tableView:self didSelectShopAtIndexPath:indexPath];
        
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) { //商店布局
        
        return [self.delegate tableView:self cellForShopRowAtIndexPath:indexPath];
        
    }else {
        
        MenuTableViewCell * menuCell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
        menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        menuCell.marketIndex = (NSInteger)indexPath.section;//市场
        menuCell.shopIndex = (NSInteger)indexPath.row/2;//商店
        menuCell.delegate = self;
        [menuCell layoutMenuTableView];
        
        [menuCell.tableView reloadData];
       
        return menuCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) {
        
        return [self.delegate tableView:self heightForShopRowAtIndexPath:indexPath];//看seciton
    }else {
        
        return [self.delegate tableView:self heightForAllProductsRowAtIndexPath:indexPath];//看section
    }
}

#pragma mark - MenuTableViewDelegate

//共有多少个商品
- (NSInteger)numberOfMCSectionsInTableView:(MenuTableViewCell *)tableViewCell {
    
    return [self.delegate numberOfProductsAtShop:tableViewCell.shopIndex marketIndex:tableViewCell.marketIndex];
}

- (NSInteger)tableView:(MenuTableViewCell *)tableViewCell numberOfMCRowsInSection:(NSInteger)section {
    
    return [self.delegate numberOfCategorysAtProduct:(NSInteger)section shopIndex:tableViewCell.shopIndex marketIndex:tableViewCell.marketIndex];
}

- (CGFloat)tableView:(MenuTableViewCell *)tableViewCell heightForMCRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.delegate tableView:tableViewCell.tableView heightForCaregoryRowAtIndexPath:indexPath shopIndex:tableViewCell.shopIndex marketIndex:tableViewCell.marketIndex];
}

- (UITableViewCell *)tableView:(MenuTableViewCell *)tableViewCell cellForMCRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.delegate tableView:tableViewCell.tableView cellForCategoryRowAtIndexPath:indexPath shopIndex:tableViewCell.shopIndex  marketIndex:tableViewCell.marketIndex];
}

- (void)tableView:(MenuTableViewCell *)tableViewCell didSelectMCRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate tableView:tableViewCell.tableView didSelectRowAtIndexPath:indexPath shopIndex:tableViewCell.shopIndex  marketIndex:tableViewCell.marketIndex];
}

#pragma mrak -

- (void)reloadMenuData {
    
    [self.tableView reloadData];
}

- (void)reloadMenuSections:(NSIndexSet *)indexSet {
    
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
