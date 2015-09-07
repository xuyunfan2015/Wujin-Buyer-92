//
//  GoOtherCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@protocol GoOtherCellDelegate <NSObject>

- (void)goOtherCellDidClickAtIndex:(int)index;

@end

@interface GoOtherCell : UITableViewCell

@property (assign,nonatomic) id<GoOtherCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet WTURLImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *line;
@end
