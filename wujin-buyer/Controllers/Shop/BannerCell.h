//
//  BannerCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@interface BannerCell : UITableViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (void)initBannerCell;

@end
