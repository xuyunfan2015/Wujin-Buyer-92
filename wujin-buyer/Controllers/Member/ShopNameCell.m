//
//  ShopNameCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopNameCell.h"

@implementation ShopNameCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)vipPay:(UIButton *)sender {
    
    if ([self.vipDelegate respondsToSelector:@selector(vipPayClickWithIndexPath:cell:)]) {
        
        [self.vipDelegate vipPayClickWithIndexPath:self.indexPath cell:self];
    }
}

+ (ShopNameCell *)shopNameCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ShopNameCell" owner:self options:nil] objectAtIndex:0];
}

- (void)selectVIPPay {
    
    [self.vip setBackgroundImage:[UIImage imageNamed:@"coin6"] forState:UIControlStateNormal];
}

- (void)cancelVIPPay {
    
    [self.vip setBackgroundImage:[UIImage imageNamed:@"coin6_2"] forState:UIControlStateNormal];
}
@end
