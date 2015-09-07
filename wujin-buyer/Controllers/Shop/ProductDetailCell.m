//
//  ProductDetailCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ProductDetailCell.h"

@implementation ProductDetailCell

- (void)awakeFromNib {
    // Initialization code
    
    self.line.transform = CGAffineTransformMakeScale(1, 0.5f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)collectAction:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(productDetailDidClickCollect)]){
        
        [self.delegate productDetailDidClickCollect];
    }
}


@end
