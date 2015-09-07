//
//  CustomAlertView.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/30.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

+ (instancetype)customAlertViewWithMessage:(NSString *)message andImage:(UIImage *)image {
    
    CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, 275, 80)];
    
    alert.backgroundColor = BLACK_COLOR;
    alert.alpha = 0.8f;
    
//    UIImageView *errImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 275, 80)];
    
//    errImage.image = [UIImage imageNamed:@"grayBackGround"];
//    errImage.image = image;
//    errImage.center = CGPointMake(alert.center.x, alert.center.y - 15);
//    
//    errImage.center = CGPointMake(alert.center.x, alert.center.y);
    
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(38, 30, 200, 40)];
    
    messageLab.font = [UIFont systemFontOfSize:14.f];
    messageLab.numberOfLines = 2;
    messageLab.textColor = WHITE_COLOR;
    messageLab.backgroundColor = CLEAR_COLOR;
    messageLab.text = message;
    messageLab.adjustsFontSizeToFitWidth = YES;
    messageLab.textAlignment = NSTextAlignmentCenter;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 275, 20)];
    title.font = [UIFont boldSystemFontOfSize:15.f];
    title.text = @"提示";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = WHITE_COLOR;
    
//    [alert addSubview:errImage];
    [alert addSubview:title];
    [alert addSubview:messageLab];
    
    alert.layer.cornerRadius = 10.f;
    alert.layer.masksToBounds = YES;
    
    return alert;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
