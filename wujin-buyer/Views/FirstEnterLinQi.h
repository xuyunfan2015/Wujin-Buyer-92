//
//  FirstEnterLinQi.h
//  wujin-buyer
//
//  Created by wujin  on 15/2/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol enterToLinQiDelegate <NSObject>

- (void)didEnterToLinQi;

@end

@interface FirstEnterLinQi : UIView

@property (strong, nonatomic) UIPageControl *page;
@property (strong, nonatomic) UIScrollView *scroll;

@property (weak, nonatomic) id<enterToLinQiDelegate> enterDelegate;

- (void)show;

+ (instancetype)firstEnterLinQi;
@end
