//
//  ShopComDetailViewCell.m
//  wujin-buyer
//
//  Created by Alan on 15/8/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopComDetailViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ShopComDetailViewCell

- (void)awakeFromNib {
    self.comment.editable=NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)loadHomePageDetailWithDetailList:(NSDictionary *)comments{
    NSString *address=[NSString stringWithFormat:@"%@%@",hostUrl,[comments objectForKey:@"uimg"]];
    [self.icon setImageWithURL:[NSURL URLWithString:address]];
    self.comment.text=comments[@"content"];
    self.name.text=comments[@"unickname"];
    self.data.text=comments[@"createtime"];
    self.icon.layer.cornerRadius = self.icon.frame.size.width / 2;
    self.icon.clipsToBounds = YES;
}
@end
