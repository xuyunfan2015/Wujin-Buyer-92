//
//  PayWayCell.m
//  wujin-buyer
//
//  Created by jensen on 15/6/28.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "PayWayCell.h"

@implementation PayWayCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)payAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(paywayCell:didSelectedAtIndex:)]) {
        
        [self.delegate paywayCell:self didSelectedAtIndex:self.index];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
