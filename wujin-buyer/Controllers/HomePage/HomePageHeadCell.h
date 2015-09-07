//
//  HomePageHeadCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *homeScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *homePagePageControl;

- (void)loadHomePageHeadCellWithImages:(NSArray *)aArr;
@end
