//
//  ShopImageTableViewCell.m
//  wujin-buyer
//
//  Created by Alan on 15/8/25.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopImageTableViewCell.h"
#import "UIButton+WebCache.h"
#import "UIButton+WebCache.h"
@implementation ShopImageTableViewCell

- (void)awakeFromNib {
   // [self.buttonone setImageWithURL: forState:<#(UIControlState)#>]
}
//-(void)loadHomePageDetailWithDetailList:(HomePageDetailList *)shopInfo
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadHomePageDetailWithDetailList:(NSArray *)imageaddress{
    
    if (imageaddress.count>=1) {
        NSString *addstr=[NSString stringWithFormat:@"%@%@",hostUrl,imageaddress[0]];
       // NSLog(@"addresss1=========================%@",addstr);
        self.buttonone.imageView.frame = self.buttonone.bounds;
        self.buttonone.hidden = NO;
        //[self.buttonone setImageWithURL:[NSURL URLWithString:addstr]];
        [self.buttonone sd_setImageWithURL:[NSURL URLWithString:addstr] forState:UIControlStateNormal];
    }
    if (imageaddress.count>=2) {
        NSString *addstr=[NSString stringWithFormat:@"%@%@",hostUrl,imageaddress[1]];
       
       // [self.button2 setImageWithURL:[NSURL URLWithString:addstr]];
        [self.button2 sd_setImageWithURL:[NSURL URLWithString:addstr] forState:UIControlStateNormal];
        
    }
    if (imageaddress.count>=3) {
        NSString *addstr=[NSString stringWithFormat:@"%@%@",hostUrl,imageaddress[2]];
        //NSLog(@"addresss3=========================%@",addstr);
        //[self.button3 setImageWithURL:[NSURL URLWithString:addstr]];
        [self.button3 sd_setImageWithURL:[NSURL URLWithString:addstr] forState:UIControlStateNormal];
        
    }

}

@end
