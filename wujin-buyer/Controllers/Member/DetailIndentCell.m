//
//  DetailIndentCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/14.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "DetailIndentCell.h"
#import "UIImageView+loadURL.h"

@implementation DetailIndentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickIndexPath:(UIButton *)sender {
    
    if ([self.detailIndentDelegate respondsToSelector:@selector(detailIndentCellClickIndent:)]) {
        
        [self.detailIndentDelegate detailIndentCellClickIndent:self.indexPath];
    }
}

- (void)loadDetailIndentCellWithInfo:(DetailIndentInfo *)aInfo {
    
    self.productImage.layer.cornerRadius = 5.0f;
    self.productImage.layer.masksToBounds = YES;
    [self.productImage.layer setNeedsDisplay];
    
    [self.productImage loadURL:aInfo.image];
    
    self.productName.text = aInfo.name;
    self.productCategory.text = aInfo.category;
    self.productMoney.text = [NSString stringWithFormat:@"￥%@", aInfo.money];
    self.productNumber.text = [NSString stringWithFormat:@"x%@", aInfo.number];
    
    if (0 == [aInfo.state intValue]) {
        
        [self.refundState setTextColor:BLACK_COLOR];
    } else {
        
        [self.refundState setTextColor:RED_COLOR];
    }
    
    self.refundState.text = aInfo.message;
}

+ (DetailIndentCell *)detailIndentCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"DetailIndentCell" owner:self options:nil] lastObject];
}

- (void)selectRefundProduct {
    
    [self.selectProduct setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
}

- (void)cancelRefundProduct {
    
    [self.selectProduct setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
}
@end
