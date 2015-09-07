//
//  ProductDetailCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@protocol ProductDetailDelegate <NSObject>

- (void)productDetailDidClickCollect;

@end

@interface ProductDetailCell : UITableViewCell

@property (nonatomic,assign) id<ProductDetailDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *productName;
//现价
@property (weak, nonatomic) IBOutlet UILabel *curPrice;

//原价
@property (weak, nonatomic) IBOutlet UILabel *oPrice;

@property (weak, nonatomic) IBOutlet UILabel *dealCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *addrssLabel;

@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIImageView *line;
@end
