//
//  CollectProductCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/12.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CollectProductCell.h"
#import "UIImageView+loadURL.h"

@implementation CollectProductCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)loadCollectProductCellWithProductInfo:(CollectProductInfo *)cellInfo {
    
    self.collectProductImage.layer.cornerRadius = 5.0f;
    self.collectProductImage.layer.masksToBounds = YES;
    [self.collectProductImage.layer setNeedsDisplay];
    
    NSURL *_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,cellInfo.collectProductImage]];
    [self.collectProductImage setURL:_url];
    
    self.collectProductName.text = cellInfo.collectProductName;
    self.collectProductPrice.text = [NSString stringWithFormat:@"￥%@", cellInfo.collectProductPrice];
}
@end
