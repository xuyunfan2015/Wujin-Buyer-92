//
//  ShopCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@protocol ShopCellDelegate <NSObject>

- (void)shopCellDidCallAtIndex:(NSInteger) index;

@end

@interface ShopCell : UITableViewCell

@property (assign, nonatomic) NSInteger index;

@property (assign, nonatomic) id<ShopCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet WTURLImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopThings;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

@end
