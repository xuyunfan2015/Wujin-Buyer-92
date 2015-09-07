//
//  CarCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/13.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell

- (void)awakeFromNib {
    // Initialization code
    
    self.line.transform = CGAffineTransformMakeScale(1, 0.5);
}

- (IBAction)addAction:(id)sender {
    
    int curNumber = [self.numberField.text intValue];
    curNumber ++;
    
    self.numberField.text = [NSString stringWithFormat:@"%d",curNumber];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carCell:didUpdateCurrentNumberAtPosition:)]) {
        
        [self.delegate carCell:self didUpdateCurrentNumberAtPosition:[self getPostion]];
    }
}

- (IBAction)subAction:(id)sender {
    
    int curNumber = [self.numberField.text intValue];
    if (curNumber > 1) {
        
        curNumber --;
        
        self.numberField.text = [NSString stringWithFormat:@"%d",curNumber];

        if (self.delegate && [self.delegate respondsToSelector:@selector(carCell:didUpdateCurrentNumberAtPosition:)]) {
            
            [self.delegate carCell:self didUpdateCurrentNumberAtPosition:[self getPostion]];
        }
    }
}

- (IBAction)selectCate:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carCell:didShowSelectCategoryAtPosition:)]) {
        
        [self.delegate carCell:self didShowSelectCategoryAtPosition:[self getPostion]];
    }
    
}

- (Position)getPostion {
    
    Position postion;
    postion.marketIndex = (int)self.selectButton.marketIndex;
    postion.shopIndex = (int)self.selectButton.shopIndex;
    postion.productIndex = (int)self.selectButton.productIndex;
    postion.detailIndex = (int)self.selectButton.detailIndex;
    
    return postion;
}

- (void)setIsSelected:(BOOL)selected {
    
    if (selected) {
        
        [self.sButton setImage:TTImage(@"coin5") forState:UIControlStateNormal];
        
    }else {
        
        [self.sButton setImage:TTImage(@"coin4") forState:UIControlStateNormal];
    }
    
    [self.selectButton changeState:selected];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editNumberAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carCell:didResetNumber:)]) {
        
        [self.delegate carCell:self didResetNumber:[self getPostion]];
    }
}

@end
