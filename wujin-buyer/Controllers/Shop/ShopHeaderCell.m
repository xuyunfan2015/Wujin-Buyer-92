//
//  ShopHeaderCell.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopHeaderCell.h"

@implementation ShopHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)categoryAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(shopHeaderViewDidSelectedCate:)]) {
        
        [self.delegate shopHeaderViewDidSelectedCate:self];
    }
    
}


@end
