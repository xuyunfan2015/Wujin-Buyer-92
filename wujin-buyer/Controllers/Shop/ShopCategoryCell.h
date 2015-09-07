//
//  ShopCategoryCell.h
//  wujin-buyer
//
//  Created by jensen on 15/6/19.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@interface ShopCategoryCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet WTURLImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;

@property (weak, nonatomic) IBOutlet UILabel *otherCategory;
@end
