//
//  CarHeaderView.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/13.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CarHeaderView.h"

@implementation CarHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init {
    
    self = [super init];
    
    if (nil != self) {
        
        self.upLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    }
    
    return self;
}

- (IBAction)telAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carHeader:didCallWithShopInfo:)]) {
        
        [self.delegate carHeader:self didCallWithShopInfo:self.shopInfo];
    }
}

- (IBAction)messageAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carHeader:didChatWithShopInfo:)]) {
        
        [self.delegate carHeader:self didChatWithShopInfo:self.shopInfo];
    }
}

- (IBAction)goShopAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carHeader:didSelectShopWithShop:)]) {
        
        [self.delegate carHeader:self didSelectShopWithShop:self.shopInfo];
    }
    
}


@end
