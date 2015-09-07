//
//  CustomNavigationBar.h
//  wujin-buyer
//
//  Created by wujin  on 15/2/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UIView

+ (CustomNavigationBar *)customNavigationBar;
@end

@protocol CustomNavigationBarDelegate <NSObject>

- (void)clickLeftButton:(UIButton *)sender;

- (void)clickRightButton:(UIButton *)sender;

@end