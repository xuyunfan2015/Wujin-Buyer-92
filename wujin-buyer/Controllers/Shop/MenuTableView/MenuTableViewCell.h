//
//  MenuTableViewCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/21.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuTableViewCell;

@protocol MenuTableViewCellDelegate <NSObject>

- (NSInteger)numberOfMCSectionsInTableView:(MenuTableViewCell *)tableViewCell;//市场的个数

- (NSInteger)tableView:(MenuTableViewCell *)tableViewCell numberOfMCRowsInSection:(NSInteger)section;

- (CGFloat)tableView:(MenuTableViewCell *)tableViewCell heightForMCRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)tableView:(MenuTableViewCell *)tableView cellForMCRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(MenuTableViewCell *)tableViewCell didSelectMCRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MenuTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) NSInteger shopIndex;//代表的是哪个商店

@property (assign,nonatomic) NSInteger marketIndex;//代表市场

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign,nonatomic) id<MenuTableViewCellDelegate> delegate;

- (void)layoutMenuTableView;

@end
/*
 {
 err = 1;
 errMsg = "\U6210\U529f";
 result =     {
 money = 214;
 shoppingCart =         (
 {
 marketID = 14;
 name = "\U5609\U5b9a\U4e94\U91d1\U5e02\U573a";
 sellerLevel =                 (
 {
 name = "\U79e6\U987a\U4e94\U91d1\U5e97";
 phone = 13862243243;
 productLevel =                         (
 {
 name = "\U8d77\U5b50\U5957\U88c5\U7ec4\U5408";
 productDetailLevel =                                 (
 {
 ID = 416;
 image = "images/product_imgs/fb844113d3b2a7ce1ebd150a1236b067.jpg";
 name = "\U5927\U53f7";
 number = 1;
 price = "12.00";
 productDetailID = 124;
 }
 );
 productID = 215;
 },
 {
 name = "\U5fb7\U56fd\U5bb6\U7528\U5de5\U5177\U7bb1\U7535\U5de5\U7ef4\U4fee\U7ec4\U5408\U5957\U88c5\U7ec4\U5957\U5e26\U7535\U94bb";
 productDetailLevel =                                 (
 {
 ID = 421;
 image = "images/product_imgs/c6976f91f44f81cd8ded43b2108ac6d4.jpg";
 name = "\U7ec4\U5408\U5957\U88c511\U4ef6";
 number = 1;
 price = "202.00";
 productDetailID = 129;
 }
 );
 productID = 217;
 }
 );
 sellerID = 118;
 }
 );
 }
 );
 };
 }
 */







/*
{
    err = 1;
    errMsg = "\U6210\U529f";
    result =     {
        money = 202;
        shoppingCart =         (
                                {
                                    marketID = 14;
                                    name = "\U5609\U5b9a\U4e94\U91d1\U5e02\U573a";
                                    sellerLevel =                 (
                                                                   {
                                                                       name = "\U79e6\U987a\U4e94\U91d1\U5e97";
                                                                       phone = 13862243243;
                                                                       productLevel =                         (
                                                                                                               {
                                                                                                                   name = "\U5fb7\U56fd\U5bb6\U7528\U5de5\U5177\U7bb1\U7535\U5de5\U7ef4\U4fee\U7ec4\U5408\U5957\U88c5\U7ec4\U5957\U5e26\U7535\U94bb";
                                                                                                                   productDetailLevel =                                 (
                                                                                                                                                                         {
                                                                                                                                                                             ID = 421;
                                                                                                                                                                             image = "images/product_imgs/c6976f91f44f81cd8ded43b2108ac6d4.jpg";
                                                                                                                                                                             name = "\U7ec4\U5408\U5957\U88c511\U4ef6";
                                                                                                                                                                             number = 1;
                                                                                                                                                                             price = "202.00";
                                                                                                                                                                             productDetailID = 129;
                                                                                                                                                                         }
                                                                                                                                                                         );
                                                                                                                   productID = 217;
                                                                                                               }
                                                                                                               );
                                                                       sellerID = 118;
                                                                   }
                                                                   );
                                }
                                );
    };
}
*/