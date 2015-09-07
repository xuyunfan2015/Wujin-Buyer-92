//
//  CollectShopCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectShopInfo.h"
#import "WTURLImageView.h"

@interface CollectShopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet WTURLImageView *collectShopImage;
@property (weak, nonatomic) IBOutlet UILabel *collectShopName;
@property (weak, nonatomic) IBOutlet UILabel *collectShopTelephone;
@property (weak, nonatomic) IBOutlet UILabel *mainBusiness;

- (void)loadCollectShopCellWithShopInfo:(CollectShopInfo *)cellInfo;
@end
