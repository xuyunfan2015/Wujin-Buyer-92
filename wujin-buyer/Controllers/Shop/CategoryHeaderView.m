//
//  CategoryHeaderView.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CategoryHeaderView.h"
#import "UIView+KGViewExtend.h"

#define SELECTED_COLOR [UIColor colorWithRed:0.165 green:0.647 blue:0.875 alpha:1.000]
#define NO_SELECTED_COLOR  [UIColor colorWithWhite:0.643 alpha:1.000]

@implementation CategoryHeaderView

- (void)layoutWithCategorys:(NSArray *)categorys {
    
    self.categorys = categorys;
   
    int width = K_UIMAINSCREEN_WIDTH / [categorys count];
    
    dispatch_async(dispatch_get_main_queue(), ^{
         self.selectedView.width = width;
    });
    
    self.selectedView.backgroundColor = SELECTED_COLOR;
    
    for (int index = 0; index < [categorys count]; index ++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.frame = CGRectMake(width * index, 0, width, 35);
        button.tag = 8000 + index;
        [button setTitle:[categorys[index] valueForKey:@"spnam"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (self.selectedIndex == index) {
            
            [button setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
        
        }else {
             [button setTitleColor:NO_SELECTED_COLOR forState:UIControlStateNormal];
            
        }
    }
}

#pragma mark - 设置滑动到这个位置

- (void)setScrollAtIndex:(int)index {

    if (self.selectedIndex == index) {
        
        return;
    }
    
    UIButton * button = (UIButton *)[self viewWithTag:8000 + self.selectedIndex ];
    [button setTitleColor:NO_SELECTED_COLOR forState:UIControlStateNormal];
    
    self.selectedIndex = index;
    
    UIButton * button1 = (UIButton *)[self viewWithTag:8000 + self.selectedIndex ];
    [button1 setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
    
    int width = K_UIMAINSCREEN_WIDTH / [self.categorys count];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.selectedView.left = index * width;
        
    }];
    
}

#pragma mark - Actions

- (void)selectAction:(UIButton *)button {
    
    int tag = button.tag - 8000;
    
    if (tag == self.selectedIndex) {
        
        return;
    }
    
    UIButton * button2 = (UIButton *)[self viewWithTag:8000 + self.selectedIndex ];
    [button2 setTitleColor:NO_SELECTED_COLOR forState:UIControlStateNormal];
    
    self.selectedIndex = tag;
    
    UIButton * button1 = (UIButton *)[self viewWithTag:8000 + self.selectedIndex ];
    [button1 setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
    
    int width = K_UIMAINSCREEN_WIDTH / [self.categorys count];

    [UIView animateWithDuration:0.3 animations:^{
        
        self.selectedView.left = tag * width;
        
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryHeaderView:didSelectedAtIndex:)]) {
        
        [self.delegate categoryHeaderView:self didSelectedAtIndex:tag];
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
