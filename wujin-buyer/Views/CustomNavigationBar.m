//
//  CustomNavigationBar.m
//  wujin-buyer
//
//  Created by wujin  on 15/2/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (CustomNavigationBar *)customNavigationBar {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"CustomNavigationBar" owner:nil options:nil] lastObject];
}

@end
