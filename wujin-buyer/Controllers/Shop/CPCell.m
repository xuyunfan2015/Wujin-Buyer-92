//
//  CPCell.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CPCell.h"

@implementation CPCell

- (IBAction)subAction:(id)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(cpCell:subWithCarInfo:)]) {
        
        [self.delegate cpCell:self subWithCarInfo:self.carInfo];
    }
}

- (IBAction)addAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cpCell:addWithCarInfo:)]) {
        
        [self.delegate cpCell:self addWithCarInfo:self.carInfo];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
