//
//  ShopOtherInfoCell.m
//  wujin-buyer
//
//  Created by Alan on 15/8/25.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopOtherInfoCell.h"

@implementation ShopOtherInfoCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)loadHomePageDetailWithDetailList:(HomePageDetailList *)shopInfo{
    if (nil != shopInfo) {
        
        self.saddress.text = [NSString stringWithFormat:@"地址：%@",shopInfo.saddress];
        self.srema.text=[NSString stringWithFormat:@"个人宣言：%@",shopInfo.srema];
        self.introduction.text=[NSString stringWithFormat:@"个人简介：%@",shopInfo.introduction];
        
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
