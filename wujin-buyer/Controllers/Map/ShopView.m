//
//  ShopView.m
//  wujin-buyer
//
//  Created by jensen on 15/6/28.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopView.h"

@implementation ShopView

-(void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.backView.alpha = 0.5;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tapGesture.numberOfTapsRequired = 1;
    [self.backView addGestureRecognizer:tapGesture];
}

- (void)openWithShopInfo:(NSDictionary *)productInfo inSuperView:(UIView *)superView {
    
    self.shopInfo = productInfo;
    
    [superView addSubview:self];//添加到view上
    
    //////设置图片
    NSString * cmimg = [CommentRequest getCompleteImageURLStringWithSubURL:[productInfo valueForKey:@"img"]];
    [self.imageView setURL:cmimg defaultImage:PLACE_HORDER_IMAGE(self.imageView)];
    
    self.nameLabel.text = [NSString stringWithFormat:@"店铺名:%@",[productInfo valueForKey:@"name"]];
    
    self.addressLabel.text = [NSString stringWithFormat:@"店铺地址:%@",[productInfo valueForKey:@"address"]];
    
      self.phoneField.text = [NSString stringWithFormat:@"店铺电话:%@",[productInfo valueForKey:@"mobile"]];
    
    self.alpha = 0;//alpha 设置为
    //动画出现
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)closeAction:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        self.alpha = 1;
        
    }];
    
}

- (void)tapAction {
    
    [self closeAction:nil];
}

- (IBAction)gotoShopAction:(id)sender {
    
    [self tapAction];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(shopView:didGotoShop:)]) {
        
        [self.delegate shopView:self didGotoShop:self.shopInfo];
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
