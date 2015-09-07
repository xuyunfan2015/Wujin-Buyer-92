//
//  VIPIndentHeardCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPIndentHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *didPayMoney;
@property (weak, nonatomic) IBOutlet UILabel *doNotPayMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@property (weak, nonatomic) IBOutlet UIView *downLine;
@property (weak, nonatomic) IBOutlet UIView *upLine;
@property (weak, nonatomic) IBOutlet UIView *rightLine;
@property (weak, nonatomic) IBOutlet UIView *leftLine;


+ (VIPIndentHeaderCell *)vipIndentHeaderCell;

- (void)loadVIPIndentHeaderWithDictionary:(NSDictionary *)aDic;
@end
