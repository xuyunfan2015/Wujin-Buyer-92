//
//  ShopProductView.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/7.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@interface ShopProductViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet WTURLImageView *productHeaderImageView;

@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@end
