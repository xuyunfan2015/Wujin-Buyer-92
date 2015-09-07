//
//  FirstEnterLinQi.m
//  wujin-buyer
//
//  Created by wujin  on 15/2/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "FirstEnterLinQi.h"

@implementation FirstEnterLinQi

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)firstEnterLinQi {
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    FirstEnterLinQi *_first = [[FirstEnterLinQi alloc] initWithFrame:frame];
    
    UIScrollView  *scroll = [[UIScrollView alloc] initWithFrame:frame];
    
    _first.scroll = scroll;
    
    for (NSInteger i = 1; i <= 5; ++i) {
    
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"Enter%@.jpg", @(i)]];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:img];
        
        image.frame = CGRectMake((i - 1) * K_UIMAINSCREEN_WIDTH, 0, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT);
        
        [_first.scroll addSubview:image];
    }
    
    UIButton *enterLinqi = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH/3, 25)];
    
    enterLinqi.center = CGPointMake(4*K_UIMAINSCREEN_WIDTH + K_UIMAINSCREEN_WIDTH/2, 4*K_UIMAINSCREEN_HEIGHT/7 - 20);
    
    [enterLinqi setBackgroundImage:[UIImage imageNamed:@"EnterLinqi"] forState:UIControlStateNormal];
    
    [enterLinqi addTarget:_first action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    _first.scroll.pagingEnabled = YES;
    _first.scroll.bounces = NO;
    _first.scroll.showsHorizontalScrollIndicator = NO;
    _first.scroll.showsVerticalScrollIndicator = NO;
    _first.scroll.contentSize = CGSizeMake(5*K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT);
    
    UIPageControl *seg = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 10)];
    
    seg.center = CGPointMake(K_UIMAINSCREEN_WIDTH/2, K_UIMAINSCREEN_HEIGHT - 40);
    
    seg.numberOfPages = 5;
    
    seg.currentPageIndicatorTintColor = [UIColor greenColor];
    seg.pageIndicatorTintColor = RGBCOLOR(204, 204, 204);
    
    seg.userInteractionEnabled = NO;
    _first.page = seg;
    
    [_first.scroll addSubview:enterLinqi];
    
    [_first addSubview:_first.scroll];
    [_first addSubview:seg];
    
    return _first;
}

- (void)show {
    
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];
}

- (void)cancel:(UIButton *)sender {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.transform = CGAffineTransformMakeScale(2, 2);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if ([self.enterDelegate respondsToSelector:@selector(didEnterToLinQi)]) {
            
            [self.enterDelegate didEnterToLinQi];
        }
    }];
}
@end
