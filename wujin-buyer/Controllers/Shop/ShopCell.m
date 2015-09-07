//
//  ShopCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (void)awakeFromNib {
    // Initialization code
    
    self.shopImage.layer.cornerRadius = 5.0f;
    
    self.shopImage.layer.masksToBounds = YES;
    
    [self.shopImage.layer setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)phoneAction:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(shopCellDidCallAtIndex:)]){
        
        [self.delegate shopCellDidCallAtIndex:self.index];
    }
}

@end
