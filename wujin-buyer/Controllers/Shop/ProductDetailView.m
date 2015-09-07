//
//  ProductDetailView.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ProductDetailView.h"

@implementation ProductDetailView

-(void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.backView.alpha = 0.5;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tapGesture.numberOfTapsRequired = 1;
    [self.backView addGestureRecognizer:tapGesture];
}

- (void)openWithProductInfo:(NSDictionary *)productInfo inSuperView:(UIView *)superView {
    
    self.productInfo = productInfo;

    self.numberField.text = @"1";//初始化数量
    
    [superView addSubview:self];//添加到view上
    
    //////设置图片
    NSString * cmimg = [CommentRequest getCompleteImageURLStringWithSubURL:[productInfo valueForKey:@"cmimg"]];
    [self.imageView setURL:cmimg defaultImage:PLACE_HORDER_IMAGE(self.imageView)];
    
    self.nameLabel.text = [productInfo valueForKey:@"cmname"];
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[productInfo valueForKey:@"cmprice"]];
    
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
- (IBAction)subAction:(id)sender {
    
    int number = [self.numberField.text intValue];
    
    if (number <= 1) {
        
        return;
    }
   
    number = number - 1;
    
    self.numberField.text = [NSString stringWithFormat:@"%d",number];

}

- (IBAction)addAction:(id)sender {
    
    int number = [self.numberField.text intValue];
    
    number = number + 1;
    
    self.numberField.text = [NSString stringWithFormat:@"%d",number];

}
- (IBAction)addToCarAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addToCarWithProductInfo:number:)]) {
        
        [self.delegate addToCarWithProductInfo:self.productInfo number:self.numberField.text];
    }
}

- (void)tapAction {
    
    [self closeAction:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
