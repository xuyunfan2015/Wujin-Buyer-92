//
//  CustomNavigationView.h
//  wujin-buyer
//
//  Created by wujin  on 15/2/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  CustomNavigationViewDelegate;

@interface CustomNavigationView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWithContraint;//左边view 的宽

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLeftContaint;//右边view的左边
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidthConstaint;//右边view 的宽

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightButtonWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCo;


@property (weak, nonatomic) IBOutlet UIImageView *lineImage;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (weak, nonatomic) id<CustomNavigationViewDelegate> navigationDelegate;

+ (instancetype)customNavigationView;

@end

@protocol CustomNavigationViewDelegate <NSObject>

@optional

- (void)navigationViewLeftButton:(UIButton *)sender;

- (void)navigationViewRightButton:(UIButton *)sender;

@end