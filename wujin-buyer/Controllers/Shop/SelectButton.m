//
//  SelectButton.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/20.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

- (void)setIsSelected:(BOOL)isSelected {
    
    _isSelected = isSelected;
    
    if (isSelected) {
        
        [self setImage:TTImage(@"coin5") forState:UIControlStateNormal];

    }else {
        
        [self setImage:TTImage(@"coin4") forState:UIControlStateNormal];
    }
}

-(void)changeState:(BOOL)selected {
    
     _isSelected = selected;
}

- (Level)getLevel {
   
    return self.level;
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
