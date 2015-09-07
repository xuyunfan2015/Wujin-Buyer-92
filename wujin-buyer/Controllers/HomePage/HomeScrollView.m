//
//  HomeScrollView.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "HomeScrollView.h"

@implementation HomeScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)loadHeadScrollViewWithImages:(NSArray *)images {
    
    if (nil != images) {
        
        for (NSInteger i = 0; i < [images count]; ++i) {
            
            UIImageView *_image = [[UIImageView alloc] initWithFrame:CGRectMake(i*K_UIMAINSCREEN_WIDTH, 0, K_UIMAINSCREEN_WIDTH, 165)];
            
            _image.image = images[i];
            
            [self addSubview:_image];
        }
        
        UIImageView *_lastImage = [[self subviews] lastObject];
        
        self.contentSize = CGSizeMake(CGRectGetMaxX(_lastImage.frame), self.bounds.size.height);
    }
}
@end
