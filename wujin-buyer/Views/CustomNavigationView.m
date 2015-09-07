//
//  CustomNavigationView.m
//  wujin-buyer
//
//  Created by wujin  on 15/2/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CustomNavigationView.h"

@implementation CustomNavigationView

+ (instancetype)customNavigationView {
    
    NSArray *_arr = [[NSBundle mainBundle] loadNibNamed:@"CustomNavigationView" owner:nil options:nil];
    
    CustomNavigationView *view = [_arr lastObject];
    
    view.lineImage.transform = CGAffineTransformMakeScale(1, 0.5);
    
    view.frame = CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 64);
    
    return view;
}

-(void)awakeFromNib{

    self.rightButton.hidden = YES;

}

- (IBAction)clickLeftButton:(UIButton *)sender {
    
    if ([self.navigationDelegate respondsToSelector:@selector(navigationViewLeftButton:)]) {
        
        [self.navigationDelegate navigationViewLeftButton:self.leftButton];
    }
}

- (IBAction)clickRightButton:(UIButton *)sender {
    
    if ([self.navigationDelegate respondsToSelector:@selector(navigationViewRightButton:)]) {
        
        [self.navigationDelegate navigationViewRightButton:self.rightButton];
    }
}
@end
