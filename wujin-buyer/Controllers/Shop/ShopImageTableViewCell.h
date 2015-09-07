//
//  ShopImageTableViewCell.h
//  wujin-buyer
//
//  Created by Alan on 15/8/25.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageDetailList.h"
@interface ShopImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeimage;
@property (weak, nonatomic) IBOutlet UILabel *typelabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonone;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

- (void)loadHomePageDetailWithDetailList:(NSArray *)imageaddress;

@end
