//
//  AddCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCellDelegate <NSObject>

- (void)addCellDidChangeNumber:(int)number;

- (void)showHintWithMsg:(NSString *)msg;

@end


@interface AddCell : UITableViewCell<UIAlertViewDelegate>


@property (assign,nonatomic) id<AddCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *numberField;

@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end
