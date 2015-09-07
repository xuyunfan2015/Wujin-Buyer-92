//
//  BannerCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BannerCell.h"

@implementation BannerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initBannerCell {
    
    self.scrollView.delegate = self;
}

#pragma mark - UIScrollDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x / K_UIMAINSCREEN_WIDTH;
    
    self.pageControl.currentPage = page;
}

@end
