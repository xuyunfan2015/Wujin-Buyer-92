//
//  OrderHeaderCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "OrderHeaderCell.h"

@implementation OrderHeaderCell

- (void)awakeFromNib {
    // Initialization code
    
    self.line.transform = CGAffineTransformMakeScale(1, 0.5);
}


#pragma mark - Actions

- (IBAction)isVipAction:(id)sender {
    
    self.isVipButton.selected = !self.isVipButton.selected;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(orderHeaderCell:selectVip:)]) {
        
        [self.delegate orderHeaderCell:self selectVip:self.isVipButton.isSelected];
    }
    
}

- (IBAction)telAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderHeaderCell:didClickTel:)]) {
        
        NSString * tel = [self.shopDic valueForKey:@"phone"];
        
        [self.delegate orderHeaderCell:self didClickTel:tel];
    }
}

- (IBAction)messageAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderHeaderCellDidClickMsg:)]) {
        
        [self.delegate orderHeaderCellDidClickMsg:self];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
