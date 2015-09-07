//
//  UIScrollView+UIScrollView_UITouch.m
//  wujin-buyer
//
//  Created by Alan on 15/9/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "UIScrollView+UIScrollView_UITouch.h"

@implementation UIScrollView (UIScrollView_UITouch)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
@end
