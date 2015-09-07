//
//  CollectShopCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CollectShopCell.h"
#import "UIImageView+loadURL.h"

@implementation CollectShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCollectShopCellWithShopInfo:(CollectShopInfo *)cellInfo {
    
    self.collectShopImage.layer.cornerRadius = 5.0f;
    self.collectShopImage.layer.masksToBounds = YES;
    [self.collectShopImage.layer setNeedsDisplay];
    
    NSURL *_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,cellInfo.collectShopImage]];
    [self.collectShopImage setURL:_url];
    
    self.collectShopName.text = cellInfo.collectShopName;
    self.collectShopTelephone.text = cellInfo.collectShopTelephone;
    self.mainBusiness.text = [NSString stringWithFormat:@"主营:%@", cellInfo.mainBusiness];
}
@end
