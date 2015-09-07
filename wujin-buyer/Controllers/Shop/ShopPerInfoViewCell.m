//
//  ShopPerInfoViewCell.m
//  wujin-buyer
//
//  Created by Alan on 15/8/25.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopPerInfoViewCell.h"
#import "UIImageView+loadURL.h"
@implementation ShopPerInfoViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)loadHomePageDetailWithDetailList:(HomePageDetailList *)shopInfo {
    
    if (nil != shopInfo) {
        //设置圆形头像
       // self.img.layer.cornerRadius = self.img.frame.size.width / 2;
      //  self.img.clipsToBounds = YES;
        self.img.layer.cornerRadius = 5.0f;
        self.img.layer.masksToBounds = YES;
        [self.img.layer setNeedsDisplay];
        
        [self.img loadURL: shopInfo.shopImage];
        self.sname.text = shopInfo.shopName;
        self.age.text = [NSString stringWithFormat:@"年龄：%@",shopInfo.age];
        self.cage.text=[NSString stringWithFormat:@"厨龄：%@",shopInfo.cage];
        self.shanc.text=[NSString stringWithFormat:@"擅长：%@",shopInfo.shanc];
        self.smobile.text=[NSString stringWithFormat:@"电话：%@",shopInfo.smobile];
        
            }
}
@end
