//
//  MemberInforViewController.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/7.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol QuitEnterDelegate <NSObject>

- (void)quitEnter;

@end

@interface MemberInfoViewController : BaseViewController

@property (strong, nonatomic) UIImage *portrait;

@property (weak, nonatomic) id<QuitEnterDelegate> quitDelegate;
@end


