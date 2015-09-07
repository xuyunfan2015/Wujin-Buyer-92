//
//  AcceptViewController.h
//  wujin-buyer
//
//  Created by wujin  on 15/2/10.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AcceptDelegate;

@interface AcceptView : UIView

@property NSInteger selected;

@property NSInteger section;

@property (weak, nonatomic) id<AcceptDelegate> acceptDelegate;

+ (instancetype)acceptView;

//按钮
@property (weak, nonatomic) IBOutlet UIButton *good;
@property (weak, nonatomic) IBOutlet UIButton *general;
@property (weak, nonatomic) IBOutlet UIButton *bad;

@end

@protocol AcceptDelegate <NSObject>

- (void)acceptSection:(NSInteger)section type:(NSInteger)type;

@end