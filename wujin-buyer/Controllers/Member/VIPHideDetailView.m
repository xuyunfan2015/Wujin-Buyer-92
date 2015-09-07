//
//  VIPHideDetailView.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "VIPHideDetailView.h"

@implementation VIPHideDetailView

+ (instancetype)VIPHideDetailView {
    
    VIPHideDetailView *_vipView = [[VIPHideDetailView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 44)];
    
    _vipView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, K_UIMAINSCREEN_WIDTH, 44)];
    
    _button.backgroundColor = WHITE_COLOR;
    
    [_button addTarget:_vipView action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _vipView->_shopName = [[UILabel alloc] initWithFrame:_button.bounds];
    
    
    UIImageView *_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indent_detail_2"]];
    _image.frame = CGRectMake(K_UIMAINSCREEN_WIDTH - 22, 10, 12, 20);
    
    UIImageView *upLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 1)];
    UIImageView *downLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, K_UIMAINSCREEN_WIDTH, 1)];
    
    UIImage *line = [UIImage imageNamed:@"gray_line"];
    
    upLine.image = line;
    downLine.image = line;
    upLine.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    downLine.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    
    
    [_vipView addSubview:_button];
    [_vipView addSubview:_vipView->_shopName];
    [_vipView addSubview:_image];
    [_vipView addSubview:upLine];
    [_vipView addSubview:downLine];
    
    return _vipView;
}

- (void)buttonAction:(UIButton *)sender {
    
    if ([self.VIPHIdeDelegate respondsToSelector:@selector(VIPHideDetailClick:atSection:)]) {
        
        [self.VIPHIdeDelegate VIPHideDetailClick:self atSection:self.tag];
    }
}

- (void)setShopName:(NSString *)name {
    
    _shopName.text = [NSString stringWithFormat:@"  店铺:%@", name];
    
    _shopName.font = [UIFont systemFontOfSize:16.f];
}
@end
