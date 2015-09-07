//
//  SelectButton.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/20.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum LEVEL{
    LEVEL_ALL,
    LEVEL_MARKET,
    LEVEL_SHOP,
    LEVEL_PRODUCT,
    LEVEL_DETAIL
}Level;

@interface SelectButton : UIButton

@property (assign, nonatomic) Level level;

@property (assign, nonatomic) NSInteger marketIndex;
@property (assign, nonatomic) NSInteger shopIndex;
@property (assign, nonatomic) NSInteger productIndex;
@property (assign, nonatomic) NSInteger detailIndex;

@property (assign,nonatomic) BOOL isSelected;

- (Level)getLevel;

-(void)changeState:(BOOL)selected;

@end
