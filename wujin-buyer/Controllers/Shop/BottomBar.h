//
//  BottomBar.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BottomBar;

@protocol BottomBarDelegate <NSObject>

- (void)bottomBar:(BottomBar *)bottomBar didSelectAtIndex:(NSInteger)index;

@end

@interface BottomBar : UIView

@property (assign,nonatomic) id<BottomBarDelegate> delegate;

- (void)layoutWithTitles:(NSArray *)titles;

@end
