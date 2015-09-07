//
//  addressCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/7.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfo.h"

@interface AddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UIImageView *defaulAddress;
@property (weak, nonatomic) IBOutlet UILabel *address;

- (void)loadCellContentWithInfo:(AddressInfo *)aList;

@end
