//
//  VIPIndentHeardCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "VIPIndentHeaderCell.h"

@implementation VIPIndentHeaderCell

- (void)awakeFromNib {
    // Initialization code
    self.upLine.transform = CGAffineTransformMakeScale(1, 0.5);
    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5);
    self.rightLine.transform = CGAffineTransformMakeScale(0.5, 1);
    self.leftLine.transform = CGAffineTransformMakeScale(0.5, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadVIPIndentHeaderWithDictionary:(NSDictionary *)aDic {
    
    if (nil != aDic) {
        
        self.didPayMoney.text = [NSString stringWithFormat:@"￥%@", aDic[@"didPay"]];
        self.doNotPayMoney.text = [NSString stringWithFormat:@"￥%@", aDic[@"waitPay"]];
        self.totalMoney.text = [NSString stringWithFormat:@"￥%@", aDic[@"money"]];
    }
}

+ (VIPIndentHeaderCell *)vipIndentHeaderCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"VIPIndentHeaderCell" owner:self options:nil] objectAtIndex:0];
}
@end
