//
//  addressCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/7.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCellContentWithInfo:(AddressInfo *)aInfo {
    
    if (nil != aInfo) {
        
        self.name.text =[NSString stringWithFormat:@"姓名:%@", aInfo.name];
        self.telephone.text = [NSString stringWithFormat:@"电话:%@",aInfo.telephone];
        self.address.text = [NSString stringWithFormat:@"收获地址:%@%@", aInfo.address,aInfo.detailAddress];
    }
}

@end
