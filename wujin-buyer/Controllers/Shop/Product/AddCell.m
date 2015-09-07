//
//  AddCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AddCell.h"
#import "AppUtil.h"
#import "MyAlertView.h"

@implementation AddCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changNumberAction:(id)sender {
    
    MyAlertView * alertView = [[MyAlertView alloc] initWithTitle:nil message:@"输入购买数量" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField * textF = [alertView textFieldAtIndex:0];
    textF.keyboardType = UIKeyboardTypeNumberPad;
    
    [alertView show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
            
//        MyAlertView * mAlertView = (MyAlertView *)alertView;
        
        UITextField * text1 = [alertView textFieldAtIndex:0];
            
        NSString * number = text1.text;
            
        if ([number intValue] > 0) {
            
            _numberField.text = [NSString stringWithFormat:@"%@",number];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(addCellDidChangeNumber:)]) {
                
                [self.delegate addCellDidChangeNumber:[number intValue]];
            }
                
        }else {
        
            if (self.delegate && [self.delegate respondsToSelector:@selector(showHintWithMsg:)]) {
                
                [self.delegate showHintWithMsg:@"最少数量为1"];
            }
        }
    }
}

- (IBAction)subAction:(id)sender {
    
    NSString * numberStr = _numberField.text;
    
    int number = [numberStr intValue];
    
    if (number <= 1) {
        
        
    }else {
        
        number --;
        _numberField.text = [NSString stringWithFormat:@"%d",number];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCellDidChangeNumber:)]) {
        
        [self.delegate addCellDidChangeNumber:number];
    }
}

- (IBAction)addAction:(id)sender {
    
    NSString * numberStr = _numberField.text;
    
    int number = [numberStr intValue];
    
    number ++;
    
    _numberField.text = [NSString stringWithFormat:@"%d",number];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCellDidChangeNumber:)]) {
        
        [self.delegate addCellDidChangeNumber:number];
    }

}


@end
