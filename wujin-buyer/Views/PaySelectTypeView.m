//
//  PaySelectTypeView.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/23.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "PaySelectTypeView.h"

@implementation PaySelectTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (nil != self) {
        self.backgroundColor = CLEAR_COLOR;
        
        //背景层
        UIView *backView = [[UIView alloc] initWithFrame:frame];
        
        backView.backgroundColor = BLACK_COLOR;
        backView.alpha = 0.6f;
        backView.opaque = NO;
        
        //呈现层
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH*2/3, K_UIMAINSCREEN_HEIGHT*2/3)];
        
        const CGFloat buttonHeight = showView.frame.size.height/7.0f;
        
        NSArray *payType = [NSArray arrayWithObjects:@"取消", @"支付宝-APP版", @"支付宝-网页版", @"微信-APP版", @"微信-公众账号", @"手机银联支付", @"网页银联支付", nil];
        
        for (NSInteger i = [payType count] - 1; i >= 0; --i) {
            
            //位置代码，请忽略
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, (6 - i)*(buttonHeight - 10) + 20, showView.frame.size.width - 40, buttonHeight - 20)];
            
            button.tag = i;
            
            [button setTitle:payType[i] forState:UIControlStateNormal];
            
            UIImage *_image;
            if (0 != i) {
                
                _image = [[UIImage imageNamed:@"coin2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
                
                [button setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
            } else {
                
                _image = [[UIImage imageNamed:@"button_background2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            }
            [button setBackgroundImage:_image forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [showView addSubview:button];
        }
        
        UIView *lastView = [showView.subviews lastObject];
        
        showView.backgroundColor = WHITE_COLOR;
        showView.frame = CGRectMake(0, 0, showView.frame.size.width, CGRectGetMaxY(lastView.frame) + 20);
        showView.layer.cornerRadius = 5.f;
        showView.layer.masksToBounds = YES;
        showView.center = self.center;
        
        [self addSubview:backView];
        [self addSubview:showView];
    }
    
    
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            
            [self removeFromSuperview];
            break;
            
        default:
            
            if ([self.payDelegate respondsToSelector:@selector(PaySelect:Type:)]) {
                
                [self.payDelegate PaySelect:self Type:sender.tag];
            }
            
            [self removeFromSuperview];
            break;
    }
}
@end
