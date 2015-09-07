//
//  HmoePageDetailCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageDetailList.h"

@interface HomePageDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@property (weak, nonatomic) IBOutlet UIView *HighlightedView;
@property (weak, nonatomic) IBOutlet UIImageView *downLine;
@property (weak, nonatomic) IBOutlet UIImageView *upLine;
- (void)loadHomePageDetailWithDetailList:(HomePageDetailList *)shopInfo;
@end
