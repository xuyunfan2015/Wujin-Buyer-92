//
//  AcceptViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/2/10.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AcceptView.h"

@interface AcceptView ()

@end

@implementation AcceptView

+ (instancetype)acceptView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"AcceptView" owner:nil options:nil] firstObject];
}
- (IBAction)Accept:(id)sender {
    
    if ([self.acceptDelegate respondsToSelector:@selector(acceptSection: type:)]) {
        
        [self.acceptDelegate acceptSection:self.section type:self.selected];
    }
    
    [self removeFromSuperview];
}

- (IBAction)cancel:(id)sender {
    
    [self removeFromSuperview];
}

- (IBAction)evaluate:(UIButton *)sender {
    
    self.selected = sender.tag;
    
    switch (sender.tag) {
        case 1:
            
            [self.good setImage:[UIImage imageNamed:@"coin5"] forState:UIControlStateNormal];
            
            [self.general setImage:[UIImage imageNamed:@"coin4"] forState:UIControlStateNormal];
            
            [self.bad setImage:[UIImage imageNamed:@"coin4"] forState:UIControlStateNormal];
            break;
            
        case 2:
            
            [self.good setImage:[UIImage imageNamed:@"coin4"] forState:UIControlStateNormal];
            
            [self.general setImage:[UIImage imageNamed:@"coin5"] forState:UIControlStateNormal];
            
            [self.bad setImage:[UIImage imageNamed:@"coin4"] forState:UIControlStateNormal];
            break;
            
        case 3:
            
            [self.good setImage:[UIImage imageNamed:@"coin4"] forState:UIControlStateNormal];
            
            [self.general setImage:[UIImage imageNamed:@"coin4"] forState:UIControlStateNormal];
            
            [self.bad setImage:[UIImage imageNamed:@"coin5"] forState:UIControlStateNormal];
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
