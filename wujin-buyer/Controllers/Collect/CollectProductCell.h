//
//  CollectProductCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectProductInfo.h"
#import "WTURLImageView.h"

@interface CollectProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet WTURLImageView *collectProductImage;
@property (weak, nonatomic) IBOutlet UILabel *collectProductName;
@property (weak, nonatomic) IBOutlet UILabel *collectProductPrice;

- (void)loadCollectProductCellWithProductInfo:(CollectProductInfo *)cellInfo;
@end
