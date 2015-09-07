//
//  HmoePageDetailCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "HomePageDetailCell.h"
#import "UIImageView+loadURL.h"

@implementation HomePageDetailCell

- (void)awakeFromNib {
    // Initialization code
    
    self.upLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    [self setNeedsDisplay];
}

- (void)loadHomePageDetailWithDetailList:(HomePageDetailList *)shopInfo {
    
    if (nil != shopInfo) {
        //设置圆形头像
        self.shopImage.layer.cornerRadius = self.shopImage.frame.size.width / 2;
        self.shopImage.clipsToBounds = YES;
        //self.shopImage.layer.cornerRadius = 5.0f;
        //self.shopImage.layer.masksToBounds = YES;
        [self.shopImage.layer setNeedsDisplay];
        
        [self.shopImage loadURL: shopInfo.shopImage];
        self.shopName.text = shopInfo.shopName;
        self.shopAddress.text = shopInfo.shopAddress;
        //self.distanceLabel.text = [NSString stringWithFormat:@"%.1f米", [shopInfo.distance floatValue]];
        self.distanceLabel.text = [NSString stringWithFormat:@"%@", shopInfo.shanc];
    }
}

- (void)drawRect:(CGRect)rect {
    
    if (self.highlighted) {
        
        self.HighlightedView.backgroundColor = RGBCOLOR(210, 210, 210);
    } else {
        
        self.HighlightedView.backgroundColor = WHITE_COLOR;
    }
}
@end
