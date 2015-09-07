//
//  CarBottomBar.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/13.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CarBottomBar.h"

@implementation CarBottomBar

- (IBAction)operAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carBottomBarDidClick:)]) {
        
        [self.delegate carBottomBarDidClick:self];
    }
    
}

- (void)setIsSelected:(BOOL)selected {
    
    if (selected) {
        
        [self.sButton setImage:TTImage(@"coin5") forState:UIControlStateNormal];
        
    }else {
        
        [self.sButton setImage:TTImage(@"coin4") forState:UIControlStateNormal];
    }

    [self.selectedButton changeState:selected];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
