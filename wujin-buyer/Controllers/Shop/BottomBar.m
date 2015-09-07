//
//  BottomBar.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BottomBar.h"
#import "UIView+KGViewExtend.h"

@implementation BottomBar

- (void)layoutWithTitles:(NSArray *)titles {
    
    self.backgroundColor = WHITE_COLOR;//[UIColor colorWithRed:0.932 green:0.920 blue:0.929 alpha:1.000];
    
    for (int index = 0; index < [titles count]; index ++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000 + index;
        [button setTitleColor:RGBCOLOR(98, 98, 98) forState:UIControlStateNormal];
        [button setTitle:titles[index] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        button.frame = CGRectMake(K_UIMAINSCREEN_WIDTH/[titles count] * index, 0 , K_UIMAINSCREEN_WIDTH/[titles count], 44);
        [button addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: button];
        
       if (index != [titles count] - 1) {
            
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(K_UIMAINSCREEN_WIDTH/[titles count] * (index + 1) - 1, 0, 1, button.height)];
           lineView.backgroundColor = [UIColor colorWithRed:0.880 green:0.868 blue:0.877 alpha:1.000];
            [self addSubview:lineView];
       }
    }
    
    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 1)];
    topLine.backgroundColor = [UIColor colorWithRed:0.880 green:0.868 blue:0.877 alpha:1.000];
    [self addSubview:topLine];
}

#pragma mark - Actions

- (void)touchAction:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBar:didSelectAtIndex:)]) {
        
        [self.delegate bottomBar:self didSelectAtIndex:button.tag - 1000];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
