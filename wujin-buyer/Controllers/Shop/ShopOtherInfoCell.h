//
//  ShopOtherInfoCell.h
//  wujin-buyer
//
//  Created by Alan on 15/8/25.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageDetailList.h"
@interface ShopOtherInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *saddress;
@property (weak, nonatomic) IBOutlet UILabel *srema;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
- (void)loadHomePageDetailWithDetailList:(HomePageDetailList *)shopInfo;
@end
