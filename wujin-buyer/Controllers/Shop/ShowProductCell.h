//
//  ShowProductCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"
#import "ShopHeaderView.h"

@interface ShowProductCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *myContentView;

@property (weak, nonatomic) IBOutlet WTURLImageView *productHeaderImageView;

@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@property (strong,nonatomic) ShopHeaderView * shopHeaderView;

- (void)layoutSubViewsWithType:(int)type;//0 header  1.其他

@end
