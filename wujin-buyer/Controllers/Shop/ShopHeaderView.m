//
//  ShowHeaderView.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopHeaderView.h"
#import "HomePageDetailList.h"
#import "UIView+KGViewExtend.h"

@implementation ShopHeaderView

- (void)layoutWithShopInfo:(HomePageDetailList *)shopInfo {

    self.homePageList = shopInfo;
   
    self.addressLabel.text = shopInfo.shopAddress;
    [self.addressLabel sizeToFit];
    
   float startOffset =  (K_UIMAINSCREEN_WIDTH -  (self.locationView.width + 8 + self.addressLabel.width))/2;
    
    self.locationView.left = startOffset;
    self.addressLabel.left = self.locationView.right + 8;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",shopInfo.statetime,shopInfo.endtime];
    
    self.shfwLabel.text = shopInfo.sscore;
    
    self.swjgLabel.text = [NSString stringWithFormat:@"%@元",shopInfo.sfprice];

}

- (IBAction)callAction:(id)sender {
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.homePageList.smobile]]];

}

- (void)awakeFromNib {
    // Initialization code
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
