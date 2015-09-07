//
//  CustomActivityIndicator.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/9.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CustomActivityIndicator.h"

@implementation CustomActivityIndicator

+ (instancetype)customActivityIndicatorWithMessage:(NSString *)message {
    CustomActivityIndicator *background = [[CustomActivityIndicator alloc] initWithFrame:CGRectMake(0, 64, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT - 64)];
    
    background.backgroundColor = CLEAR_COLOR;
    
    UIView *show = [[CustomActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    show.backgroundColor = BLACK_COLOR;
    show.alpha = 0.8f;
    
    UIActivityIndicatorView *_activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.center = CGPointMake(show.center.x, 35);
    [_activity startAnimating];
    
    [show addSubview:_activity];
    
    UILabel *_mess = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_activity.frame) + 10, 100, 30)];
    _mess.text = message;
    _mess.backgroundColor = [UIColor clearColor];
    _mess.textColor = WHITE_COLOR;
    _mess.minimumScaleFactor = 0.5f;
    _mess.adjustsFontSizeToFitWidth= YES;
    _mess.textAlignment = NSTextAlignmentCenter;
    _mess.font = [UIFont systemFontOfSize:15.f];
    
    [show addSubview:_mess];
    
    show.layer.cornerRadius = 10;
    [show.layer setNeedsDisplay];
    show.layer.masksToBounds = YES;
    //show.center = background.center;
    show.frame = CGRectMake((K_UIMAINSCREEN_WIDTH - 100)/2, (K_UIMAINSCREEN_HEIGHT - 128 - 100)/2, 100, 100);
    
    [background addSubview:show];
    
    return background;
}

@end
