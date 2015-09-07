//
//  ShopFooterCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/15.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopFooterCell.h"

@implementation ShopFooterCell

- (IBAction)buttonAction:(UIButton *)sender {
    
    if ([self.payDelegate respondsToSelector:@selector(payClickAtSection:andButton:)]) {
        
        [self.payDelegate payClickAtSection:self.section andButton:sender];
    }
}
- (IBAction)callTelephone:(UIButton *)sender {
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    
    if (nil != title) {
        
        if ([self.payDelegate respondsToSelector:@selector(callTelephone:)]) {
            
            NSRange range = [title rangeOfString:@"("];
            NSString *telephone = [title substringWithRange:NSMakeRange(range.location + 1, title.length - range.location - 2)];
            
            [self.payDelegate callTelephone:telephone];
        }
    }
}

- (void)loadShopFooterCellWithIndentInfo:(HistoryIndentInfo *)aInfo {
    
    NSString *freight = [NSString stringWithFormat:@"运费:￥%@", aInfo.freight];
    NSString *money = [NSString stringWithFormat:@"￥%@", aInfo.money];
    
    self.totalMoney.text = money;
    _freight.text = freight;
    [self.express setTitle:aInfo.expressInfo forState:UIControlStateNormal];
    
    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.upLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    if (0 == [aInfo.isNotFreight intValue]) {
        
        NSUInteger length = [_freight.text length];
        
        NSMutableAttributedString *strAttr = [[NSMutableAttributedString alloc] initWithString:_freight.text]; //绘制删除线
        [strAttr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid) range:NSMakeRange(0, length)];
        [strAttr addAttribute:NSStrikethroughColorAttributeName value:BLACK_COLOR range:NSMakeRange(0, length)];
        
        [_freight setAttributedText:strAttr];
    }
}

+ (ShopFooterCell *)shopFooterCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ShopFooterCell" owner:self options:nil] objectAtIndex:0];
}
@end
