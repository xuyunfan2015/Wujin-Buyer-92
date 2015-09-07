//
//  ShopPerInfoViewCell.h
//  wujin-buyer
//
//  Created by Alan on 15/8/25.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageDetailList.h"
@interface ShopPerInfoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *sname;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *shanc;
@property (weak, nonatomic) IBOutlet UILabel *smobile;
@property (weak, nonatomic) IBOutlet UILabel *cage;

- (void)loadHomePageDetailWithDetailList:(HomePageDetailList *)shopInfo;
@end
