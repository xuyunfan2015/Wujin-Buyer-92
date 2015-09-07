//
//  CarBottomBar.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/13.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectButton.h"

@class CarBottomBar;

@protocol CarBottomDelegate <NSObject>

- (void)carBottomBarDidClick:(CarBottomBar *)carBottomBar;

@end

@interface CarBottomBar : UIView

@property (assign, nonatomic) id<CarBottomDelegate> delegate;

@property (assign,nonatomic) BOOL isEdit;

@property (weak, nonatomic) IBOutlet SelectButton *selectedButton;

@property (weak, nonatomic) IBOutlet UIView *downLine;
@property (weak, nonatomic) IBOutlet UIView *upLine;

@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet UIButton *operButton;

@property (weak, nonatomic) IBOutlet UIButton *sButton;

- (void)setIsSelected:(BOOL)selected;




@end
