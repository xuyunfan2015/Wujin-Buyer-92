//
//  OrderCarCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "OrderCarCell.h"

@implementation OrderCarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)subAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderCarCell:subAtIndex:)]) {
        
        [self.delegate orderCarCell:self subAtIndex:self.index];
    }
}

- (IBAction)addAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderCarCell:addAtIndex:)]) {
        
        [self.delegate orderCarCell:self addAtIndex:self.index];
    }
}




@end
