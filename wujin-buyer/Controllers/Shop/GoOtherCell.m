//
//  GoOtherCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "GoOtherCell.h"

@implementation GoOtherCell

- (void)awakeFromNib {
    // Initialization code
    
    self.line.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    self.imageView.layer.cornerRadius = 5.f;
    
    self.imageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)productCategoryAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goOtherCellDidClickAtIndex:)]) {
        
        [self.delegate goOtherCellDidClickAtIndex:0];
    }
}

- (IBAction)gotoShopAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goOtherCellDidClickAtIndex:)]) {
        
        [self.delegate goOtherCellDidClickAtIndex:1];
    }
}

@end
