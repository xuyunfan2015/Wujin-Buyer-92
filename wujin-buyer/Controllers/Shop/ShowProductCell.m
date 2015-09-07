//
//  ShowProductCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShowProductCell.h"

@implementation ShowProductCell

/**
 @property (weak, nonatomic) IBOutlet WTURLImageView *productHeaderImageView;
 
 @property (weak, nonatomic) IBOutlet UILabel *productName;
 
 @property (weak, nonatomic) IBOutlet UILabel *productPrice;
 */

- (void)layoutSubViewsWithType:(int)type {
    
    if (type == 0) {
        
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShopHeaderView" owner:nil options:nil];
        _shopHeaderView = [nibView objectAtIndex:0];
        _shopHeaderView.frame = CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_WIDTH/2);
        
        [self.contentView addSubview:_shopHeaderView];
        
        [self.productPrice setHidden:YES];
        [self.productName setHidden:YES];
        [self.productHeaderImageView setHidden:YES];
        
    }else {
        
        [_shopHeaderView setHidden:YES];
        
        [self.productPrice setHidden:NO];
        [self.productName setHidden:NO];
        [self.productHeaderImageView setHidden:NO];
    }
}


@end
